import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';

/// 表示稳定度分层结果，供首页摘要和说明弹层复用。
enum StabilityScoreLevel {
  /// 样本不足，不能给出正式评分。
  insufficient,

  /// 作息稳定。
  steady,

  /// 波动仍可控，处于回稳阶段。
  recovering,

  /// 波动明显，需要恢复计划。
  needsRecovery,
}

/// 稳定度领域结果，统一输出分值、等级与解释文案。
class StabilityScore {
  /// 创建稳定度结果。
  const StabilityScore({
    required this.score,
    required this.level,
    required this.sampleCount,
    required this.averageOffsetMinutes,
    required this.volatilityMinutes,
  });

  /// 稳定度分数，范围 0 到 100。
  final int score;

  /// 稳定度等级。
  final StabilityScoreLevel level;

  /// 本次评分所基于的有效样本数。
  final int sampleCount;

  /// 平均偏差分钟数，用于显示层解释分值来源。
  final int averageOffsetMinutes;

  /// 波动幅度分钟数，用于稳定度说明。
  final int volatilityMinutes;
}

/// 统一承接阶段七稳定度评分规则，避免页面层重复计算波动。
class StabilityScoreRules {
  const StabilityScoreRules._();

  /// 根据最近 7 天有效记录计算稳定度分数和等级。
  static StabilityScore calculate({
    required GoalScheduleSettings settings,
    required List<EffectiveSleepRecord> records,
  }) {
    if (records.length < 3) {
      return const StabilityScore(
        score: 0,
        level: StabilityScoreLevel.insufficient,
        sampleCount: 0,
        averageOffsetMinutes: 0,
        volatilityMinutes: 0,
      );
    }

    final offsets = records
        .map((record) => _offsetMinutes(record: record, settings: settings))
        .toList();
    final average = offsets.reduce((left, right) => left + right) / offsets.length;
    final variance = offsets
            .map((offset) => (offset - average) * (offset - average))
            .reduce((left, right) => left + right) /
        offsets.length;
    final volatility = variance.sqrt();
    final averagePenalty = average.abs() * 0.45;
    final volatilityPenalty = volatility * 0.75;
    final rawScore = (100 - averagePenalty - volatilityPenalty).round();
    final score = rawScore.clamp(0, 100);

    if (score >= 80) {
      return const StabilityScore(
        score: 80,
        level: StabilityScoreLevel.steady,
        sampleCount: 0,
        averageOffsetMinutes: 0,
        volatilityMinutes: 0,
      ).copyWith(
        score: score,
        sampleCount: offsets.length,
        averageOffsetMinutes: average.round(),
        volatilityMinutes: volatility.round(),
      );
    }
    if (score >= 60) {
      return const StabilityScore(
        score: 60,
        level: StabilityScoreLevel.recovering,
        sampleCount: 0,
        averageOffsetMinutes: 0,
        volatilityMinutes: 0,
      ).copyWith(
        score: score,
        sampleCount: offsets.length,
        averageOffsetMinutes: average.round(),
        volatilityMinutes: volatility.round(),
      );
    }
    return const StabilityScore(
      score: 0,
      level: StabilityScoreLevel.needsRecovery,
      sampleCount: 0,
      averageOffsetMinutes: 0,
      volatilityMinutes: 0,
    ).copyWith(
      score: score,
      sampleCount: offsets.length,
      averageOffsetMinutes: average.round(),
      volatilityMinutes: volatility.round(),
    );
  }

  /// 统一按目标作息换算单条记录偏差，保证周报和稳定度口径一致。
  static int offsetMinutes({
    required EffectiveSleepRecord record,
    required GoalScheduleSettings settings,
  }) {
    return _offsetMinutes(record: record, settings: settings);
  }

  static int _offsetMinutes({
    required EffectiveSleepRecord record,
    required GoalScheduleSettings settings,
  }) {
    final target = DateTime.utc(
      record.recordDate.year,
      record.recordDate.month,
      record.recordDate.day,
      settings.targetBedtimeMinutes ~/ 60,
      settings.targetBedtimeMinutes % 60,
    );
    return record.fellAsleepAt.difference(target).inMinutes;
  }
}

extension on num {
  /// 本地平方根实现，避免为简单分值规则额外引入复杂依赖。
  double sqrt() {
    if (this <= 0) {
      return 0;
    }
    var x = toDouble();
    var previous = 0.0;
    while ((x - previous).abs() > 0.001) {
      previous = x;
      x = (x + toDouble() / x) / 2;
    }
    return x;
  }
}

extension on StabilityScore {
  /// 在复用常量文案模板时替换最终分值，减少重复拼装。
  StabilityScore copyWith({
    int? score,
    StabilityScoreLevel? level,
    int? sampleCount,
    int? averageOffsetMinutes,
    int? volatilityMinutes,
  }) {
    return StabilityScore(
      score: score ?? this.score,
      level: level ?? this.level,
      sampleCount: sampleCount ?? this.sampleCount,
      averageOffsetMinutes: averageOffsetMinutes ?? this.averageOffsetMinutes,
      volatilityMinutes: volatilityMinutes ?? this.volatilityMinutes,
    );
  }
}

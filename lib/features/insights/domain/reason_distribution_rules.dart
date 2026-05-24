import 'package:rhythm/features/insights/domain/weekly_report.dart';

/// 统一承接原因标签分布统计，限定只统计已确认标签。
class ReasonDistributionRules {
  const ReasonDistributionRules._();

  /// 按出现次数降序生成原因分布列表。
  static List<ReasonDistributionItem> build({
    required Iterable<List<String>> tagGroups,
  }) {
    final counts = <String, int>{};
    var total = 0;
    for (final tags in tagGroups) {
      for (final tag in tags) {
        final normalized = tag.trim();
        if (normalized.isEmpty) {
          continue;
        }
        counts[normalized] = (counts[normalized] ?? 0) + 1;
        total++;
      }
    }

    if (total == 0) {
      return const <ReasonDistributionItem>[];
    }

    final items = counts.entries.map((entry) {
      return ReasonDistributionItem(
        label: entry.key,
        count: entry.value,
        ratio: entry.value / total,
      );
    }).toList();
    items.sort((left, right) {
      final byCount = right.count.compareTo(left.count);
      if (byCount != 0) {
        return byCount;
      }
      return left.label.compareTo(right.label);
    });
    return items;
  }
}

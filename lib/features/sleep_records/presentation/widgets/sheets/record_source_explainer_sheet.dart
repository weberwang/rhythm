import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 数据来源说明弹层，用于解释来源、修正与可信度的展示语义。
class RecordSourceExplainerSheet extends StatelessWidget {
  /// 创建数据来源说明弹层。
  const RecordSourceExplainerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.recordSourceExplainerTitle,
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.recordSourceExplainerDescription,
                style: textTheme.bodyMedium?.copyWith(color: const Color(0xFF4A6B52)),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _SourceChip(label: l10n.recordSourceExplainerChipHealthKit),
                  _SourceChip(label: l10n.recordSourceExplainerChipManual),
                  _SourceChip(label: l10n.recordSourceExplainerChipConfidence),
                ],
              ),
              const SizedBox(height: 18),
              _SourceSection(
                title: l10n.recordSourceExplainerHealthTitle,
                body: l10n.recordSourceExplainerHealthBody,
              ),
              const SizedBox(height: 12),
              _SourceSection(
                title: l10n.recordSourceExplainerManualTitle,
                body: l10n.recordSourceExplainerManualBody,
              ),
              const SizedBox(height: 12),
              _SourceSection(
                title: l10n.recordSourceExplainerConfidenceTitle,
                body: l10n.recordSourceExplainerConfidenceBody,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 说明弹层顶部的短标签，用于对齐 Pencil 里的轻量信息提示。
class _SourceChip extends StatelessWidget {
  const _SourceChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFDCE8D8),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: const Color(0xFF4A6B52),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 说明弹层里的语义分组，避免页面层直接堆叠文案。
class _SourceSection extends StatelessWidget {
  const _SourceSection({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: const Color(0xFF1B3A28),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: textTheme.bodyMedium?.copyWith(color: const Color(0xFF4A6B52)),
            ),
          ],
        ),
      ),
    );
  }
}

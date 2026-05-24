import 'package:flutter/material.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_status.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染三种今晚状态选择，保持首屏行为干预入口足够直接。
class BedtimeStatusSection extends StatelessWidget {
  /// 创建状态区块。
  const BedtimeStatusSection({
    super.key,
    required this.selectedStatus,
    required this.onSelected,
  });

  /// 当前已选状态。
  final BedtimeStatus? selectedStatus;

  /// 状态点击回调。
  final ValueChanged<BedtimeStatus> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.bedtimeStatusTitle),
            const SizedBox(height: 12),
            _StatusTile(
              label: l10n.bedtimeStatusReady,
              status: BedtimeStatus.readyToSleep,
              selectedStatus: selectedStatus,
              onSelected: onSelected,
            ),
            const SizedBox(height: 10),
            _StatusTile(
              label: l10n.bedtimeStatusMoreTime,
              status: BedtimeStatus.wantsMoreTime,
              selectedStatus: selectedStatus,
              onSelected: onSelected,
            ),
            const SizedBox(height: 10),
            _StatusTile(
              label: l10n.bedtimeStatusLikelyLate,
              status: BedtimeStatus.likelyLate,
              selectedStatus: selectedStatus,
              onSelected: onSelected,
            ),
          ],
        ),
      ),
    );
  }
}

/// 渲染单条状态选择卡，避免页面层重复拼选择态视觉。
class _StatusTile extends StatelessWidget {
  const _StatusTile({
    required this.label,
    required this.status,
    required this.selectedStatus,
    required this.onSelected,
  });

  final String label;
  final BedtimeStatus status;
  final BedtimeStatus? selectedStatus;
  final ValueChanged<BedtimeStatus> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selected = selectedStatus == status;

    return InkWell(
      onTap: () => onSelected(status),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? colorScheme.primary : colorScheme.outlineVariant,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

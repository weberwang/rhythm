import 'package:flutter/material.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/custom_delay_tag_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 轻量原因标签选择弹层，先支持默认标签单选保存。
class SleepDelayTagPickerSheet extends StatefulWidget {
  /// 创建标签选择弹层。
  const SleepDelayTagPickerSheet({
    super.key,
    required this.tags,
    required this.selectedTags,
    required this.onSave,
    this.onCustomTag,
  });

  /// 可供选择的标签列表。
  final List<SleepDelayTag> tags;

  /// 当前已选择标签。
  final List<String> selectedTags;

  /// 保存回调。
  final ValueChanged<List<String>> onSave;

  /// 点击自定义标签时的回调。
  final Future<void> Function(String value)? onCustomTag;

  @override
  State<SleepDelayTagPickerSheet> createState() =>
      _SleepDelayTagPickerSheetState();
}

class _SleepDelayTagPickerSheetState extends State<SleepDelayTagPickerSheet> {
  String? _selectedTag;

  @override
  void initState() {
    super.initState();
    _selectedTag = widget.selectedTags.isEmpty ? null : widget.selectedTags.first;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.sleepDelayTagPickerTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in widget.tags)
                  ChoiceChip(
                    label: Text(tag.name),
                    selected: _selectedTag == tag.name,
                    onSelected: (_) {
                      setState(() {
                        _selectedTag = tag.name;
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _selectedTag == null
                  ? null
                  : () => widget.onSave(<String>[_selectedTag!]),
              child: Text(l10n.sleepDelayTagPickerSave),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () async {
                await showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return CustomDelayTagSheet(
                      onSave: (value) async {
                        if (widget.onCustomTag != null) {
                          await widget.onCustomTag!(value);
                          if (mounted && context.mounted) {
                            Navigator.of(context).pop();
                          }
                          return;
                        }
                        widget.onSave(<String>[value]);
                      },
                    );
                  },
                );
              },
              child: Text(l10n.sleepDelayTagPickerCustom),
            ),
          ],
        ),
      ),
    );
  }
}

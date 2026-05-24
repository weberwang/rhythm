import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 日历页筛选弹层，当前先承接应用和重置入口。
class CalendarFilterSheet extends StatefulWidget {
  /// 创建筛选弹层。
  const CalendarFilterSheet({
    super.key,
    required this.onlyRecordedDays,
    required this.lateOnly,
    required this.onApply,
    required this.onReset,
  });

  /// 当前是否只看有记录日期。
  final bool onlyRecordedDays;

  /// 当前是否只看晚睡日期。
  final bool lateOnly;

  /// 点击应用筛选时的回调。
  final ValueChanged<({bool onlyRecordedDays, bool lateOnly})> onApply;

  /// 点击重置筛选时的回调。
  final VoidCallback onReset;

  @override
  State<CalendarFilterSheet> createState() => _CalendarFilterSheetState();
}

class _CalendarFilterSheetState extends State<CalendarFilterSheet> {
  late bool _onlyRecordedDays;
  late bool _lateOnly;

  @override
  void initState() {
    super.initState();
    _onlyRecordedDays = widget.onlyRecordedDays;
    _lateOnly = widget.lateOnly;
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
              l10n.calendarFilterSheetTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 16),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _onlyRecordedDays,
              onChanged: (value) {
                setState(() {
                  _onlyRecordedDays = value;
                });
              },
              title: Text(l10n.calendarFilterRecordedOnly),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _lateOnly,
              onChanged: (value) {
                setState(() {
                  _lateOnly = value;
                });
              },
              title: Text(l10n.calendarFilterLateOnly),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _onlyRecordedDays = false;
                        _lateOnly = false;
                      });
                      widget.onReset();
                    },
                    child: Text(l10n.calendarFilterReset),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => widget.onApply((
                      onlyRecordedDays: _onlyRecordedDays,
                      lateOnly: _lateOnly,
                    )),
                    child: Text(l10n.calendarFilterApply),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_validation_error.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 自定义晚睡原因输入弹层。
class CustomDelayTagSheet extends StatefulWidget {
  /// 创建自定义标签弹层。
  const CustomDelayTagSheet({
    super.key,
    required this.onSave,
  });

  /// 保存输入内容。
  final Future<void> Function(String value) onSave;

  @override
  State<CustomDelayTagSheet> createState() => _CustomDelayTagSheetState();
}

/// 管理自定义标签输入、提交中状态和校验错误展示。
class _CustomDelayTagSheetState extends State<CustomDelayTagSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _isSaving = false;
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: SizedBox(
        // 二级自定义弹层保持与标签选择弹层一致的全宽呈现，避免连续操作时宽度跳变。
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.customDelayTagTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: l10n.customDelayTagHint,
                  border: const OutlineInputBorder(),
                  errorText: _errorText,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _isSaving
                    ? null
                    : () async {
                        setState(() {
                          _isSaving = true;
                          _errorText = null;
                        });
                        try {
                          final navigator = Navigator.of(context);
                          final normalized =
                              SleepDelayTagRules.validateCustomTag(
                            _controller.text,
                          );
                          await widget.onSave(normalized);
                          if (mounted && navigator.canPop()) {
                            navigator.pop();
                          }
                        } on SleepDelayTagValidationException catch (error) {
                          if (mounted) {
                            setState(() {
                              _errorText = _mapErrorText(
                                l10n: l10n,
                                error: error.error,
                              );
                            });
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isSaving = false;
                            });
                          }
                        }
                      },
                child: Text(l10n.customDelayTagSave),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 将领域校验错误翻译成输入框可直接展示的本地化提示。
  String _mapErrorText({
    required AppLocalizations l10n,
    required SleepDelayTagValidationError error,
  }) {
    switch (error) {
      case SleepDelayTagValidationError.empty:
        return l10n.customDelayTagErrorEmpty;
      case SleepDelayTagValidationError.tooLong:
        return l10n.customDelayTagErrorTooLong;
      case SleepDelayTagValidationError.duplicateDefault:
        return l10n.customDelayTagErrorDuplicate;
    }
  }
}

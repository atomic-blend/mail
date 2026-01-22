import 'package:ab_shared/components/forms/app_text_form_field.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComposerToField extends StatefulWidget {
  final List<String>? emails;
  final List<String>? erroredEmails;
  final Function(String)? onSelected;
  final Function(String)? onRemoved;
  final Color? backgroundColor;
  const ComposerToField(
      {super.key,
      this.emails,
      this.erroredEmails,
      this.onSelected,
      this.onRemoved,
      this.backgroundColor});

  @override
  State<ComposerToField> createState() => _ComposerToFieldState();
}

class _ComposerToFieldState extends State<ComposerToField> {
  TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (widget.emails != null && widget.emails!.isNotEmpty)
            Wrap(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...widget.emails!.map((email) => Padding(
                      padding: EdgeInsets.only(
                          right: $constants.insets.xs,
                          bottom: $constants.insets.xs),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: $constants.insets.xs,
                            vertical: $constants.insets.xs),
                        decoration: BoxDecoration(
                          color: widget.erroredEmails != null &&
                                  widget.erroredEmails!.contains(email)
                              ? getTheme(context).error.withValues(alpha: 0.2)
                              : Colors.grey.shade200,
                          borderRadius:
                              BorderRadius.circular($constants.insets.sm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: $constants.insets.xs),
                            Text(
                              email,
                              style: getTextTheme(context).bodyMedium,
                            ),
                            SizedBox(width: $constants.insets.xs),
                            GestureDetector(
                              child: Icon(
                                CupertinoIcons.xmark_circle_fill,
                                size: 20,
                              ),
                              onTap: () {
                                widget.onRemoved?.call(email);
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 250,
              minWidth: 100,
            ),
            child: Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  _submitEmail();
                }
              },
              child: AppTextFormField(
                controller: controller,
                backgroundColor: widget.backgroundColor,
                onChange: () {
                  // detect spaces in the controller text and add them to the to list + clear the controller text
                  _submitEmail();
                },
                onSubmitted: () {
                  // store the email to the list + clear the controller text when the user presses enter
                  _submitEmail();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitEmail() {
    // detect spaces in the controller text and add them to the to list + clear the controller text
    final email = _parseMailAddressFromInput(controller?.text ?? "");
    if (email != null) {
      setState(() {
        controller?.clear();
      });
      widget.onSelected?.call(email);
    }
  }

  String? _parseMailAddressFromInput(String input) {
    final splitTokens = [" ", ",", ";", "\n"];
    // detect spaces in the controller text and add them to the to list + clear the controller text
    for (final token in splitTokens) {
      final parts = input.split(token);
      if (parts.isNotEmpty && parts.first.contains("@")) {
        return parts.first;
      }
    }
    return null;
  }
}

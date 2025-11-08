import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class ComposerFromSelector extends StatelessWidget {
  final List<String> emails;
  final String? initialValue;
  final Function(String)? onSelected;
  const ComposerFromSelector(
      {super.key, required this.emails, this.initialValue, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: CustomDropdown<String>(
        initialItem: initialValue,
        closedHeaderPadding: EdgeInsets.symmetric(
          horizontal: $constants.insets.xs,
          vertical: $constants.insets.xxs,
        ),
        excludeSelected: true,
        decoration: CustomDropdownDecoration(
            closedFillColor: getTheme(context).surfaceContainer),
        items: emails,
        onChanged: (value) {
          if (value != null && onSelected != null) {
            onSelected!(value);
          }
        },
        headerBuilder: (context, selectedItem, enabled) => Text(
          selectedItem,
          style: getTextTheme(context).bodyMedium,
        ),
      ),
    );
  }
}

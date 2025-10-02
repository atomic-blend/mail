import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckboxAvatar extends StatelessWidget {
  final bool? checked;
  const CheckboxAvatar({super.key, this.checked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color:
            checked != true ? Colors.grey.shade200 : getTheme(context).primary,
        borderRadius: BorderRadius.circular($constants.corners.lg),
      ),
      child: Center(
          child: Icon(
        CupertinoIcons.checkmark,
        size: 16,
        color: checked != true ? Colors.grey.shade200 : Colors.white,
      )),
    );
  }
}

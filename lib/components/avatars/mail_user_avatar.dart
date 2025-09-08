import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';

class MailUserAvatar extends StatelessWidget {
  final String value;
  final bool? read;
  const MailUserAvatar({super.key, required this.value, required this.read});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular($constants.corners.full),
      ),
      child: Center(
        child: Text(
          getInitials(value),
          style: getTextTheme(context).bodyLarge!.copyWith(
                fontWeight: read != true ? FontWeight.bold : null,
              ),
        ),
      ),
    );
  }

  String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = names.length >= 2 ? 2 : 1;
    for (var i = 0; i < numWords; i++) {
      if (names[i].isNotEmpty) {
        initials += names[i][0];
      }
    }
    return initials.toUpperCase();
  }
}

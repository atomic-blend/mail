import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';

class ABToastNotification {
  final String title;
  final String message;
  final IconData icon;
  final Color color;
  final Widget? content;
  final VoidCallback onTap;

  ABToastNotification({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
    required this.onTap,
    this.content,
  });
}

class ABToastController {
  final List<ABToastNotification> notifications = [];
  void addNotification(ABToastNotification notification) {
    notifications.add(notification);
  }

  void removeNotification(ABToastNotification notification) {
    notifications.remove(notification);
  }

  void clearNotifications() {
    notifications.clear();
  }
}

class ABToastDisplay extends StatelessWidget {
  final ABToastController controller;
  const ABToastDisplay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      width: getSize(context).width * 0.5,
      height: 60,
      color: getTheme(context).surface,
      borderRadius: $constants.corners.full,
      border: Border.all(color: getTheme(context).surfaceContainerHighest),
      child: Container(),
    );
  }
}

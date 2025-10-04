import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class ABToastNotification {
  final ValueKey key;
  final String? title;
  final String? message;
  final IconData? icon;
  final Color? color;
  final Widget? content;
  final VoidCallback? onTap;

  ABToastNotification({
    required this.key,
    this.title,
    this.message,
    this.icon,
    this.color,
    this.onTap,
    this.content,
  });
}

class ABToastController extends ChangeNotifier {
  final List<ABToastNotification> notifications = [];

  void _safeNotifyListeners() {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      notifyListeners();
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void addNotification(ABToastNotification notification) {
    notifications.add(notification);
    _safeNotifyListeners();
  }

  void removeNotification(ValueKey key) {
    notifications.removeWhere((element) => element.key == key);
    _safeNotifyListeners();
  }

  void replaceNotification(ABToastNotification notification) {
    notifications.removeWhere((element) => element.key == notification.key);
    notifications.add(notification);
    _safeNotifyListeners();
  }

  void clearNotifications() {
    notifications.clear();
    _safeNotifyListeners();
  }
}

class ABToastDisplay extends StatelessWidget {
  final ABToastController controller;
  const ABToastDisplay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (controller.notifications.isEmpty) {
          return const SizedBox.shrink();
        }
        return ElevatedContainer(
          width: getSize(context).width * 0.5,
          height: 60,
          color: getTheme(context).surface,
          borderRadius: $constants.corners.full,
          border: Border.all(color: getTheme(context).surfaceContainerHighest),
          child: CarouselSlider(
            items: controller.notifications.map((notification) {
              if (notification.content != null) {
                return notification.content!;
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(notification.icon ?? CupertinoIcons.info),
                  Text(notification.title ?? ''),
                  Text(notification.message ?? ''),
                ],
              );
            }).toList(),
            options: CarouselOptions(
                aspectRatio: 16 / 9,
                autoPlay: true,
                enableInfiniteScroll: false),
          ),
        );
      },
    );
  }
}

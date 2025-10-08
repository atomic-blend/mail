import 'package:ab_shared/services/encryption.service.dart';
import 'package:ab_shared/utils/local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mail/main.dart';

class ReceivedMailProcessor {
  static process(RemoteMessage message) async {
    final payload = message.data;

    // check if the user data is initialized
    if (userData == null) {
      return;
    }

    //initialize the encryption engine
    encryptionService = EncryptionService(
        userSalt: userData!['keySet']['salt'],
        prefs: prefs!,
        userKey: userKey!,
        agePublicKey: agePublicKey!);

    // decrypt the content of the notification
    // final from = await encryptionService?.decryptString(data: payload['from']);
    final subject =
        await encryptionService?.decryptString(data: payload['subject']);
    final contentPreview = await encryptionService?.decryptString(
        data: payload['content_preview']);

    // setup notification client
    final localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final notifDetails =
        LocalNotificationUtil.getNotifDetails("main_channel", "New Mail");

    // show notification
    await localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      subject,
      contentPreview,
      notifDetails,
    );
  }
}

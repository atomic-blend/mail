import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mail/services/notifications/processors/received_mail_processor.dart';

class Processors {
  static processAndNotify(RemoteMessage message) async {
    print('Processing message: ${message.data['type']}');
    switch (message.data['type']) {
      case 'MAIL_RECEIVED':
        print('Received mail: ${message.data['subject']}');
        await ReceivedMailProcessor.process(message);
        break;
      default:
        throw UnimplementedError(
            'No processor found for payload type: ${message.data['payload_type']}');
    }
  }
}

import 'package:mail/models/mail/mail.dart';

class SearchService {
  static Future<List<dynamic>> search(List<dynamic> data, String query) async {
    final matches = [];
    for (var item in data) {
      switch (item.runtimeType) {
        case const (Mail):
          if (item.search(query)) {
            matches.add(item);
          }
          break;
        default:
          break;
      }
    }
    return matches;
  }
}

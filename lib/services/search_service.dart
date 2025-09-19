import 'package:mail/models/mail/mail.dart';

class SearchService {
  static List<dynamic> search(List<dynamic> data, String query) {
    if (query.isEmpty) {
      return [];
    }
    final matches = [];
    for (var item in data) {
      switch (item) {
        case Mail():
          if (item.search(query)) {
            matches.add(item);
          }
          break;
        case Map<String, dynamic>():
          if (_searchInMap(item, query)) {
            matches.add(item);
          }
          break;
        default:
          break;
      }
    }
    return matches;
  }

  static bool _searchInMap(Map<String, dynamic> map, String query) {
    final lowerQuery = query.toLowerCase();

    for (var entry in map.entries) {
      final key = entry.key;
      final value = entry.value;

      // Search in the key itself
      if (key.toLowerCase().contains(lowerQuery)) {
        return true;
      }

      // Search in the value based on its type
      if (_searchInValue(value, lowerQuery)) {
        return true;
      }
    }

    return false;
  }

  static bool _searchInValue(dynamic value, String lowerQuery) {
    if (value == null) return false;

    switch (value.runtimeType) {
      case const (String):
        return value.toLowerCase().contains(lowerQuery);

      case const (Map<String, dynamic>):
        return _searchInMap(value, lowerQuery);

      case const (List):
        return value.any((item) => _searchInValue(item, lowerQuery));

      case const (int):
      case const (double):
      case const (bool):
        // Skip numeric and boolean values - only search in textual fields
        return false;

      default:
        // For any other type, convert to string and search
        return value.toString().toLowerCase().contains(lowerQuery);
    }
  }
}

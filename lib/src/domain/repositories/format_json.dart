import 'dart:convert';

mixin FormatJson {
  String formatPostJson({required Map<String, dynamic> personJson}) {
    Map<String, dynamic> bodyJson = {
      'userId': personJson['id'],
      'dateTime': DateTime.now().toString(),
      'character_name': personJson['name']
    };
    return jsonEncode(bodyJson);
  }
}

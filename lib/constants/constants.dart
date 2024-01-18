import 'dart:io';

String getUrl() {
  try {
    return Platform.isAndroid? "http://192.168.1.2:5000/api": "http://localhost:5000/api";
  } catch(e) {
    return "http://localhost:5000/api";
  }
}

class Constants {
  static const String TWEET = 'Tweet';
  static const String USER = 'User';
  static const List<String> searchTypes = <String>[
    TWEET,
    USER,
  ];
  static String BASE_URL = getUrl();
}
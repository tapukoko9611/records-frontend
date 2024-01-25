import 'dart:io';

String getUrl() {
  try {
    return Platform.isAndroid? "https://records-backend.onrender.com/api": "https://records-backend.onrender.com/api";
  } catch(e) {
    return "https://records-backend.onrender.com/api";
  }
}

String getUrl1() {
  try {
    return Platform.isAndroid? "http://192.168.1.4:5000/api": "http://localhost:5000/api";
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
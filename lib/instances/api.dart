import 'package:dio/dio.dart';

class Server {
  static final Server _instance = Server._internal();
  final Dio _dio = Dio();

  factory Server() {
    return _instance;
  }

  Server._internal() {
    _dio.options.baseUrl = "https://valorant-api.com/v1";
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }
}

class ApiData {
  String? uuid;
  String? displayName;
  String? displayIcon;
  String? gameName;
}

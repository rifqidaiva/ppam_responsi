import 'package:dio/dio.dart';

class API {
  static final API _instance = API._internal();
  final Dio _dio = Dio();

  factory API() {
    return _instance;
  }

  API._internal() {
    _dio.options.baseUrl = "https://bymykel.github.io/CSGO-API/api/en/";
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<List<ApiData>> getCrates() async {
    final response = await _dio.get("crates.json");
    final List<ApiData> data = [];

    for (final item in response.data) {
      final ApiData apiData = ApiData();
      apiData.id = item["id"];
      apiData.name = item["name"];
      apiData.description = item["description"];
      apiData.image = item["image"];
      data.add(apiData);
    }

    return data;
  }
}

class ApiData {
  String? id;
  String? name;
  String? description;
  String? image;
}

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

class DioApi {

  static Dio dio() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://localhost:8080/api',
    );
    var dio = Dio(options);
    var adapter = BrowserHttpClientAdapter()..withCredentials = true;
    dio.httpClientAdapter = adapter;
    return dio;
  }

  static Future<Response<dynamic>> postRequest({required String path, Object? data}) async {
    return dio().post(
      path,
      data: data,
    );
  }

  static Future<Response<dynamic>> getRequest({required String path, Object? data}) async {
    return dio().get(
      path,
      data: data,
    );
  }

  static Future<Response<dynamic>> putRequest({required String path, Object? data}) async {
    return dio().put(
      path,
      data: data,
    );
  }

  static Future<Response<dynamic>> patchRequest({required String path, Object? data}) async {
    return dio().patch(
      path,
      data: data,
    );
  }

}
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token,
    };
    return await dio!.get(
      url,
      queryParameters: query ?? null,
    );
  }

  //////////////////////////////////////

  static Future<Response> postData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang,
    String? auth,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': auth,
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
  ////////////////////////////////////////////////

  static Future<Response> putData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang,
    String? auth,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': auth,
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}

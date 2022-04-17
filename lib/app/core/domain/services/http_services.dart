import 'package:dio/dio.dart';

abstract class HttpService {
  Future<Response<T>> get<T>({
    required String path,
    required String baseUrl,
    Map<String, dynamic>? queryParameters,
  });
}

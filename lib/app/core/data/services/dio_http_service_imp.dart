import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:legends_panel/app/core/domain/services/http_services.dart';

class DioHttpServiceImp implements HttpService {
  late Dio _dio;

  DioHttpServiceImp() {
    /// Esse não pode ser o baseUrl, por conta dos multiplos endpoints existentes na riot
    /// verificar como dinamizar posteriormente
    _dio = Dio(BaseOptions(
      baseUrl: 'https://ddragon.leagueoflegends.com',
      responseType: ResponseType.json,
      headers: {
        "X-Riot-Token": "RGAPI-463b3317-5dec-422-819c-d010a822c83f",
      }
    ));
  }

  @override
  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
    );
  }
}

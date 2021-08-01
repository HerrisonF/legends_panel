import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements Interceptor {

  Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://br1.api.riotgames.com',
      connectTimeout: 5000,
      receiveTimeout: 100000,
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        'api': '1.0.0',
        'X-Riot-Token' : 'RGAPI-f8bf7268-1938-4ee5-8ad2-07b94bca1a5f'
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("TESTEINHO 2");
    logger.d("RESPONSE[${response.data.method}]");
    return handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("TESTINHO");
    logger.d("RESPONSE[${options.data.method}]");
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("TESTINHO 1");
    logger.d("RESPONSE[${err.error}]");
    return handler.next(err);
  }
}

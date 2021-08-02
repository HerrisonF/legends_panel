import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class HeadersInterceptor extends Interceptor {

  final log = Logger();

  final errorAuth = 401;

  Dio dioClient;

  HeadersInterceptor({required this.dioClient});

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokenHeader = {
      "X-Riot-Token": "RGAPI-f8bf7268-1938-4ee5-8ad2-07b94bca1a5f"
    };
    options.headers.addAll(tokenHeader);

    log.d("uri:${options.uri}");
    log.d("baseURL:${options.baseUrl}");
    log.d("dataRequest: ${options.data}");
    log.d("HEADER: ${options.headers.toString()}");

    return super.onRequest(options, handler);
  }

  @override
  Future<FutureOr> onError(
    DioError dioError,
    ErrorInterceptorHandler handler,
  ) async {
    log.d("statusCode:${dioError.response!.statusCode}");
    log.d("statusMessage:${dioError.response!.statusMessage}");
    log.d("message :${dioError.message}");

    return dioError;
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {

    log.d("request ${response.data}");
    log.d("statusCode:${response.statusCode}");
    log.d("statusMessage:${response.statusMessage}");
    log.d(
        "dataResponse: ${response.statusCode} - ${response.data} - ${jsonEncode(response.data)}");
    return super.onResponse(response, handler);
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:legends_panel/app/constants/storage_keys.dart';
import 'package:logger/logger.dart';

class HeadersInterceptor extends Interceptor {

  final log = Logger();

  Dio dioClient;

  HeadersInterceptor({required this.dioClient});

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokenHeader = {
      "X-Riot-Token": StorageKeys.riotTokenProd
    };
    options.headers.addAll(tokenHeader);

    log.d("uri:${options.uri}");
    log.d("baseURL:${options.baseUrl}");
    log.d("dataRequest: ${options.data}");
    log.d("HEADER: ${options.headers.toString()}");

    return super.onRequest(options, handler);
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

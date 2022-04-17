import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class DioInterceptor extends Interceptor {
  final log = Logger('INTERCEPTOR');

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log.info(
        '| ___________________ INTERCEPTOR START REQUEST ____________________ |');
    log.info(
        " BaseURL: ${options.baseUrl}                                        ");
    log.info(
        " Headers: ${options.headers.toString()}                             ");
    log.info(
        '| ___________________ INTERCEPTOR END REQUEST  ____________________ |');

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    _handleResponseMessages(response: response);

    return super.onResponse(response, handler);
  }

  _handleResponseMessages({required Response response}) {
    if (response.statusCode == 200) {
      log.info(
          '| ______________ INTERCEPTOR START RESPONSE __________________ |');
      log.info(" StatusCode:${response.statusCode}                            ");
      log.info(" StatusMessage:${response.statusMessage}                      ");
      log.info(
          " Data: ${response.statusCode} - ${jsonEncode(response.data)}      ");
      log.info('| ______________ INTERCEPTOR END RESPONSE __________________ |');
    } else {
      log.warning(
          '| _____________ INTERCEPTOR START RESPONSE ________________ |');
      log.warning(" StatusCode:${response.statusCode}                         ");
      log.warning(
          " StatusMessage:${response.statusMessage}                           ");
      log.warning(
          " DataResponse: ${response.statusCode} - ${jsonEncode(response.data)}");
      log.warning('| _____________ INTERCEPTOR END RESPONSE ________________ |');
    }
  }
}

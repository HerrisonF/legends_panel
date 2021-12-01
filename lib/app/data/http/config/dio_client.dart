import 'package:dio/dio.dart';
import 'package:legends_panel/app/data/http/config/dio_client_status_code.dart';
import 'package:legends_panel/app/data/http/config/dio_interceptors_header.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:logger/logger.dart';

class DioClient {
  Dio instance = Dio();
  final log = Logger();

  DioClient({required String url}) {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
    );

    instance = Dio(options);
    instance.interceptors.clear();
    instance.interceptors.add(HeadersInterceptor(dioClient: instance));
  }

  Future<DioState> post(String path, String data, [queryParameters]) async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await instance.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      log.d(' PATH $path executed in ${stopwatch.elapsed}');
      stopwatch.stop();
      if (response.statusCode == DioClientStatusCode.SUCCESS) {
        return DioState(CustomState.SUCCESS, response);
      } else if (response.statusCode == DioClientStatusCode.UNAUTHORIZED) {
        return DioState(CustomState.UNAUTHORIZED, response);
      }
      return DioState(CustomState.BAD_REQUEST, response);
    } on DioError catch (e) {
      print("ERROR: ${e.error.toString()}");
      return DioState(CustomState.BAD_REQUEST, e.response!.data);
    }
  }

  Future<DioState> get(String path, [queryParameters]) async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await instance.get(
        path,
        queryParameters: queryParameters,
      );
      log.d(' PATH $path executed in ${stopwatch.elapsed}');
      stopwatch.stop();
      if (response.statusCode == DioClientStatusCode.SUCCESS) {
        return DioState(CustomState.SUCCESS, response);
      } else if (response.statusCode == DioClientStatusCode.UNAUTHORIZED) {
        return DioState(CustomState.UNAUTHORIZED, response);
      }
      log.d(' Not found:  ${response.data}');
      return DioState(CustomState.BAD_REQUEST, response);
    } on DioError catch (e) {
      print("ERROR: ${e.error.toString()}");
      return DioState(CustomState.BAD_REQUEST, e.response!.data);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:legends_panel/app/core/data/services/dio_interceptor.dart';
import 'package:legends_panel/app/core/domain/services/http_services.dart';
import 'package:logging/logging.dart';

class DioHttpServiceImp implements HttpService {
  late Dio _dio;
  final log = Logger('DIO_HTTP_SERVICE_IMP');

  DioHttpServiceImp() {
    BaseOptions options = _fillInitialOptions();

    _dio = Dio(options);
    _dio.interceptors.clear();
    _dio.interceptors.add(DioInterceptor());
  }

  BaseOptions _fillInitialOptions() {
    BaseOptions options = BaseOptions(
      responseType: ResponseType.json,
      headers: {
        "X-Riot-Token": "RGAPI-463b3317-5dec-422-819c-d010a822c83f",
      },
    );
    return options;
  }

  @override
  Future<Response<T>> get<T>({
    required String path,
    required String baseUrl,
    Map<String, dynamic>? queryParameters,
  }) {
    _dio.options.baseUrl = baseUrl;
    final watchTime = Stopwatch()..start();
    var response = _dio.get<T>(
      path,
      queryParameters: queryParameters,
    );
    watchTime.stop();
    log.info("PATH $path - Executed in: ${watchTime.elapsed}");
    return response;
  }
}

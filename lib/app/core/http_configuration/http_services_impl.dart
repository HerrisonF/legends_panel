import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';

/// Implementação HTTP.
class HttpServicesImp implements HttpServices {
  late Logger logger;
  late Dio _dio;

  HttpServicesImp({
    required this.logger,
  }) {
    _dio = Dio();
  }

  _getUrlBase(String requestUrl) {
    _dio.options.baseUrl = requestUrl;
  }

  /// Se a url não for enviada, então a url padrão do ambiente será
  /// inserida.
  @override
  Future<Either<Failure, Response<T>>> get<T>({
    required String url,
    required String path,
    Map<String, dynamic>? queryParameters,
    required String origin,
  }) async {
    _getUrlBase(url);

    final watchTime = Stopwatch()..start();

    logger.logDEBUG(
      "REQUEST GET - ORIGEM $origin \n"
          "URL: ${_dio.options.baseUrl} \n "
          "PATH: $path \n ",
    );

    try {
      var response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );

      watchTime.stop();

      logger.logDEBUG(
        "RESPONSE GET - ORIGEM: $origin \n"
            "URL: ${_dio.options.baseUrl} \n "
            "PATH: $path EXECUTED IN: ${watchTime.elapsed} \n "
            "BODY RESULT - ${response.toString()}",
      );

      return Right(response);

    } catch (e) {
      if (e is DioError) {
        return Left(
          Failure.dioError(e),
        );
      }

      return Left(
        Failure(
          error: e.toString(),
          status: 500,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Response<T>>> post<T>({
    required String url,
    required String path,
    required Map<String, dynamic> data,
    required String origin,
  }) async {
    try{
      _getUrlBase(url);

      final watchTime = Stopwatch()..start();

      logger.logDEBUG(
        "REQUEST POST - ORIGEM $origin \n"
            "URL: ${_dio.options.baseUrl} \n "
            "PATH: $path \n ",
      );

      var response = await _dio.post<T>(
        path,
        data: data,
      );

      watchTime.stop();

      logger.logDEBUG(
        "RESPONSE POST - ORIGEM: $origin \n"
            "URL: ${_dio.options.baseUrl} \n "
            "PATH: $path EXECUTED IN: ${watchTime.elapsed} \n "
            "BODY RESULT - ${response.toString()}",
      );

      return Right(response);
    }catch(e){
      if (e is DioError) {
        return Left(
          Failure.dioError(e),
        );
      }

      return Left(
        Failure(
          error: e.toString(),
          status: 500,
        ),
      );
    }
  }

  /// Se a url não for enviada, então a url padrão do ambiente será
  /// inserida.
  @override
  Future<Either<Failure, Response<T>>> put<T>({
    required String url,
    required String path,
    required Map<String, dynamic> data,
    required String origin,
  }) async {
    try{
      _getUrlBase(url);

      final watchTime = Stopwatch()..start();

      logger.logDEBUG(
        "REQUEST GET - ORIGEM $origin \n"
            "URL: ${_dio.options.baseUrl} \n "
            "PATH: $path \n ",
      );

      var response = await _dio.put<T>(
        path,
        data: data,
      );

      watchTime.stop();

      logger.logDEBUG(
        "RESPONSE POST - ORIGEM: $origin \n"
            "URL: ${_dio.options.baseUrl} \n "
            "PATH: $path EXECUTED IN: ${watchTime.elapsed} \n "
            "BODY RESULT - ${response.toString()}",
      );

      return Right(response);
    }catch(e){
      if (e is DioError) {
        return Left(
          Failure.dioError(e),
        );
      }

      return Left(
        Failure(
          error: e.toString(),
          status: 500,
        ),
      );
    }
  }
}

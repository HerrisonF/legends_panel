import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';

abstract class HttpServices {

  Future<Either<Failure,Response<T>>> get<T>({
    required String url,
    required String path,
    Map<String, dynamic>? queryParameters,
    required String origin,
  });

  Future<Either<Failure,Response<T>>> post<T>({
    required String url,
    required String path,
    required Map<String, dynamic> data,
    required String origin,
  });

  Future<Either<Failure,Response<T>>> put<T>({
    required String url,
    required String path,
    required Map<String, dynamic> data,
    required String origin,
  });

}
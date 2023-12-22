import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/queue_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/splash_repository/splash_repository_local.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepositoryLocalImpl extends SplashRepositoryLocal {
  late SharedPreferences sharedPreferences;

  static const origin = "SplashRepository-Queues-local";

  SplashRepositoryLocalImpl({
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, QueueModel>> fetchQueuesLocal() async {
    try {
      String? response = sharedPreferences.getString('QUEUE_DTO_KEY');

      if (response != null) {
        final json = jsonEncode(response);
        QueueDto dto = QueueDto.fromJson(jsonDecode(json));
        return Right(
          QueueModel(
            description: dto.description,
            map: dto.map,
            notes: dto.notes,
            queueId: dto.queueId,
          ),
        );
      } else {
        return Left(
          Failure(message: "A queue não foi encontrada localmente."),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca local pelas QUEUES',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> saveQueues({
    required QueueDto dto,
  }) async {
    try {
      final response = await sharedPreferences.setString(
        'QUEUE_DTO_KEY',
        dto.toJson().toString(),
      );

      return Right(response);
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha ao salvar as QUEUES localmente.',
          error: e.toString(),
        ),
      );
    }
  }
}

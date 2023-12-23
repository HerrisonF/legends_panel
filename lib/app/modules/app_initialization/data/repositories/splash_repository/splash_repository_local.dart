import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';

abstract class SplashRepositoryLocal {
  Future<Either<Failure, LolConstantsModel>> fetchLolConstantsLocal();

  Future<Either<Failure, bool>> saveLolConstants({
    required LolConstantsModel lolConstantsModel,
  });

  Future<Either<Failure, bool>> saveRegisterDate();

  Future<Either<Failure, String>> fetchRegisterDate();
}

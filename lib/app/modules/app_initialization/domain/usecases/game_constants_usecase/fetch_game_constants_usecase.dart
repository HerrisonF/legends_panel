import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';

abstract class FetchGameConstantsUsecase {
  Future<Either<Failure, LolConstantsModel>> call();
}
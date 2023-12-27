import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';

abstract class FetchActiveGameBySummonerIDUsecase {
  Future<Either<bool, ActiveGameInfoModel>> call({
    required String summonerId,
    required String region,
  });
}

import 'package:get/get.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:legends_panel/app/data/provider/profile_provider/participant_provider.dart';

class ParticipantRepository {

  ParticipantProvider _participantProvider = ParticipantProvider();

  Future<RxList<UserTier>> getUserTier(String encryptedSummonerId, String region){
    return _participantProvider.getUserTier(encryptedSummonerId, region);
  }

  String getUserTierImage(String tier){
    return _participantProvider.getUserTierImage(tier);
  }

  String getChampionBadgeUrl(String championId, String version){
    return _participantProvider.getChampionBadgeUrl(championId, version);
  }

  String getItemUrl(String itemId, String version){
    return _participantProvider.getItemUrl(itemId, version);
  }

  String getPosition(String position, String version){
    return _participantProvider.getPositionUrl(position, version);
  }

  String getSpellBadgeUrl(String spellName, String version){
    return _participantProvider.getSpellBadgeUrl(spellName, version);
  }

  Future<CurrentGameSpectator> getSpectator(String summonerId, String region){
    return _participantProvider.getSpectator(summonerId, region);
  }
}
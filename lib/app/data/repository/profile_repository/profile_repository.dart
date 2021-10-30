import 'package:get/get.dart';
import 'package:legends_panel/app/model/general/champion_mastery.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:legends_panel/app/data/provider/profile_provider/profile_provider.dart';

class ProfileRepository {

  ProfileProvider _profileProvider = ProfileProvider();

  String getProfileImage(String version, String profileIconId){
    return _profileProvider.getProfileImage(version, profileIconId);
  }

  Future<RxList<UserTier>> getUserTier(String encryptedSummonerId) async {
    return _profileProvider.getUserTier(encryptedSummonerId);
  }

  Future<RxList<ChampionMastery>> getChampionMastery(String summonerId) async {
    return _profileProvider.getChampionMastery(summonerId);
  }

  String getChampionImage(String championId){
    return _profileProvider.getChampionImage(championId);
  }

  String getMasteryImage(String level){
    return _profileProvider.getMasteryImage(level);
  }

  Future<List<String>> getMatchListIds(String puuid, int start, int count) {
    return _profileProvider.getMatchListIds(puuid, start, count);
  }

  Future<MatchDetail> getMatchById(String matchId){
    return _profileProvider.getMatchById(matchId);
  }

}
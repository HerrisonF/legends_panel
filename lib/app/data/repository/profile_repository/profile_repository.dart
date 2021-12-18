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

  Future<RxList<UserTier>> getUserTier(String encryptedSummonerId, String keyRegion) async {
    return _profileProvider.getUserTier(encryptedSummonerId, keyRegion);
  }

  Future<RxList<ChampionMastery>> getChampionMastery(String summonerId, String keyRegion) async {
    return _profileProvider.getChampionMastery(summonerId, keyRegion);
  }

  String getChampionImage(String championId){
    return _profileProvider.getChampionImage(championId);
  }
  String getCircularChampionImage(String championId){
    return _profileProvider.getCircularChampionImage(championId);
  }

  String getMasteryImage(String level){
    return _profileProvider.getMasteryImage(level);
  }

  Future<List<String>> getMatchListIds({required String puuid, required int start, required int count, required String keyRegion}) {
    return _profileProvider.getMatchListIds(puuid, start, count, keyRegion);
  }

  Future<MatchDetail> getMatchById(String matchId, String keyRegion){
    return _profileProvider.getMatchById(matchId, keyRegion);
  }

}
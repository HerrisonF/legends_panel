import 'package:get/get.dart';
import 'package:legends_panel/app/data/model/general/champion_mastery.dart';
import 'package:legends_panel/app/data/model/general/match_list.dart';
import 'package:legends_panel/app/data/model/general/user_tier.dart';
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

  Future<MatchList> getMatchList(String accountId){
    return _profileProvider.getMatchList(accountId);
  }

}
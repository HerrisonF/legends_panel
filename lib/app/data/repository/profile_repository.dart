import 'package:get/get.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/model/userTier.dart';
import 'package:legends_panel/app/data/provider/profile_provider.dart';

class ProfileRepository {

  ProfileProvider _profileProvider = ProfileProvider();

  Future<User> getUserProfile(){
    return _profileProvider.getUserProfile();
  }

  Future<User> fetchUser(String userName){
    return _profileProvider.fetchUser(userName);
  }

  Future<bool> writeProfileUser(User user){
    return _profileProvider.writeUserProfile(user);
  }

  eraseUser(){
    _profileProvider.eraseUser();
  }

  String getProfileImage(String version, String profileIconId){
    return _profileProvider.getProfileImage(version, profileIconId);
  }

  Future<RxList<UserTier>> getUserTier(String encryptedSummonerId){
    return _profileProvider.getUserTier(encryptedSummonerId);
  }

}
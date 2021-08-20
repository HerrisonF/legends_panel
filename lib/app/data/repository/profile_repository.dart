import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/provider/profile_provider.dart';

class ProfileRepository {

  ProfileProvider _profileProvider = ProfileProvider();

  Future<User> getUserProfile(){
    return _profileProvider.getUserProfile();
  }

  Future<User> findUser(String userName){
    return _profileProvider.findUser(userName);
  }

  Future<bool> writeProfileUser(User user){
    return _profileProvider.writeUserProfile(user);
  }

}

import 'package:legends_panel/app/modules/app_initialization/domain/models/user.dart';

class UserFavorite {
  List<User> userFavorites = [];

  UserFavorite();

  UserFavorite.fromJson(Map<String, dynamic> json){
    if(json['favorites'] != null){
      json['favorites'].forEach((element) {
        userFavorites.add(User.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() => {
    'favorites' : userFavorites,
  };
}
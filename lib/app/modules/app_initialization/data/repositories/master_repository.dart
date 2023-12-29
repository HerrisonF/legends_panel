import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';

class MasterRepository {
  late Logger logger;
  late HttpServices httpServices;

  static const origin = "MasterRepository";

  MasterRepository({
    required this.logger,
  });

  // Future<RunesRoom> getRunesRoomOnWeb(String regionKey) async {
  //
  //   final String path = "/cdn/latest/data/$regionKey/runesReforged.json";
  //   RunesRoom runesRoom = RunesRoom();
  //
  //   try{
  //     final response = await httpServices.get(
  //       url: API.riotDragonUrl,
  //       path: path,
  //       origin: origin,
  //     );
  //
  //     return response.fold((l) {
  //       logger.logDEBUG("RunesRoom not found ...");
  //       return runesRoom;
  //     }, (r) {
  //       for (dynamic runesRoomTemp in r.data) {
  //         runesRoom.perkStyle.add(PerkStyle.fromJson(runesRoomTemp));
  //       }
  //       logger.logDEBUG("Success to get runesRoom ...");
  //       return runesRoom;
  //     });
  //   }catch(e){
  //     logger.logDEBUG("RunesRoom not found ...");
  //     return runesRoom;
  //   }
  // }
  //
  // Future<User> readPersistedUserProfile() async {
  //   logger.logDEBUG("Reading persisted UserProfile Url ...");
  //   User user = User();
  //   try {
  //     String userString = await box.read(StorageKeys.userProfileKey);
  //     if (userString.isNotEmpty) {
  //       return User.fromJson(jsonDecode(userString));
  //     }
  //     logger.logDEBUG("No userProfile persisted found ...");
  //     return user;
  //   } catch (e) {
  //     logger.logDEBUG("Error to Read persisted UserProfile ... $e");
  //     return user;
  //   }
  // }
  //

  // String getUserTierImage(String tier) {
  //   logger.logDEBUG("building Image Tier Url ...");
  //   try {
  //     return "images/ranked_mini_emblems/${tier.toLowerCase()}.png";
  //   } catch (e) {
  //     logger.logDEBUG("Error to build Tier Image URL ... $e");
  //     return "";
  //   }
  // }
  //
  // saveFavoriteUsersForCurrentGame(UserFavorite usersFavorite) async {
  //   deleteFavoriteUsersForCurrentGame();
  //   logger.logDEBUG("Persisting FavoriteUser for current game ...");
  //   try {
  //     await box.write(
  //         StorageKeys.userFavoriteForCurrentGameKey, jsonEncode(usersFavorite));
  //     logger.logDEBUG("Success to persist favorite user for current game ...");
  //   } catch (e) {
  //     logger.logDEBUG("Error to persist favorite user for current game ... $e");
  //   }
  // }
  //
  // saveFavoriteUsersForProfile(UserFavorite usersFavorite) async {
  //   deleteFavoriteUsersForCurrentGame();
  //   logger.logDEBUG("Persisting FavoriteUser for profile ...");
  //   try {
  //     await box.write(
  //         StorageKeys.userFavoriteForProfileKey, jsonEncode(usersFavorite));
  //     logger.logDEBUG("Success to persist favorite user for profile ...");
  //   } catch (e) {
  //     logger.logDEBUG("Error to persist favorite user for profile ... $e");
  //   }
  // }
  // saveUserProfile(User user) async {
  //   logger.logDEBUG("Persisting UserProfile ...");
  //   try {
  //     await box.write(StorageKeys.userProfileKey, jsonEncode(user));
  //     logger.logDEBUG("Success to persist UserProfile ...");
  //   } catch (e) {
  //     logger.logDEBUG("Error to persist UserProfile ... $e");
  //   }
  // }
  //
}

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
  // Future<RunesRoom> getRunesRoomOnLocal() async {
  //   logger.logDEBUG("Getting RunesRoom on Local ...");
  //   try {
  //     String runesRoomString = await box.read(StorageKeys.runesRoomKey);
  //     if (runesRoomString.isNotEmpty) {
  //       logger.logDEBUG("Success to get RunesRoom on Local ...");
  //       return RunesRoom.fromJson(jsonDecode(runesRoomString));
  //     }
  //   } catch (e) {
  //     logger.logDEBUG("Error to get RunesRoom on local_imp $e");
  //     return RunesRoom();
  //   }
  //   logger.logDEBUG("runesRoom on local_imp not found ...");
  //   return RunesRoom();
  // }
  //
  // saveRunesRoom(Map<String, dynamic> runesRoom) {
  //   logger.logDEBUG("Persisting runesRoom ...");
  //   try {
  //     box.write(StorageKeys.runesRoomKey, jsonEncode(runesRoom));
  //     logger.logDEBUG("Success to persist runesRoom ...");
  //   } catch (e) {
  //     logger.logDEBUG("Error to persist runesRoom ... $e");
  //   }
  // }
  //
  // String getImageUrl(String championName, String version) {
  //   final String path =
  //       "/cdn/$version/img/champion/${championName.replaceAll(" ", "")}.png";
  //   logger.logDEBUG("building Image URL...");
  //   try {
  //     return API.riotDragonUrl + path;
  //   } catch (e) {
  //     logger.logDEBUG("Error to build Image Url $e");
  //     return "";
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
  // Future<User> getUserOnCloud(String summonerName, String keyRegion) async {
  //
  //   final String path = "/lol/summoner/v4/summoners/by-name/$summonerName";
  //
  //   try{
  //     final response = await httpServices.get(
  //       url: API.riotDragonUrl,
  //       path: path,
  //       origin: origin,
  //     );
  //
  //     return response.fold((l) {
  //       logger.logDEBUG("Error to find User");
  //       return User();
  //     }, (r) {
  //       logger.logDEBUG("Success to Found User...");
  //       return User.fromJson(r.data);
  //     });
  //   }catch(e){
  //     logger.logDEBUG("Error to find User ${e.toString()}");
  //     return User();
  //   }
  // }
}

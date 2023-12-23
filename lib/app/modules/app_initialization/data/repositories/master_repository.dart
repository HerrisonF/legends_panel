import 'dart:convert';

import 'package:legends_panel/app/core/http_configuration/api_paths_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/champion_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/runesRoom.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/stored_region.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/user.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/user_favorite.dart';

class MasterRepository {
  late Logger logger;
  late HttpServices httpServices;

  static const origin = "MasterRepository";

  MasterRepository({
    required this.logger,
  });

  // Future<ChampionRoom> getChampionRoomOnWeb() async {
  //   final String path = "/cdn/latest/data/en_US/champion.json";
  //   ChampionRoom championRoom = ChampionRoom();
  //
  //   try {
  //     final response = await httpServices.get(
  //       url: API.riotDragonUrl,
  //       path: path,
  //       origin: origin,
  //     );
  //
  //     return response.fold((l) {
  //       logger.logDEBUG("Error to get ChampionRoom");
  //       return championRoom;
  //     }, (r) {
  //       for (final name in r.data['data'].keys) {
  //         championRoom.champions.add(
  //           Champion.fromJson(r.data['data'], name),
  //         );
  //       }
  //       logger.logDEBUG("Success To get Champion Room ...");
  //       return championRoom;
  //     });
  //   } catch (e) {
  //     logger.logDEBUG("Error to get ChampionRoom $e");
  //     return championRoom;
  //   }
  // }
  //
  // Future<ChampionRoom> getChampionRoomOnLocal() async {
  //   logger.logDEBUG("Getting ChampionRoom on local_imp ...");
  //   try {
  //     String championRoomString = await box.read(StorageKeys.championRoomKey);
  //     if (championRoomString.isNotEmpty) {
  //       logger.logDEBUG("Success to get ChampionRoom on Local ...");
  //       return ChampionRoom.fromJson(
  //         jsonDecode(championRoomString),
  //       );
  //     }
  //   } catch (e) {
  //     logger.logDEBUG("Error to get ChampionRoom on local_imp $e");
  //     return ChampionRoom();
  //   }
  //   logger.logDEBUG("ChampionRoom not found on local_imp ...");
  //   return ChampionRoom();
  // }
  //
  // saveChampionRoom(Map<String, dynamic> championRoom) {
  //   logger.logDEBUG("Persisting ChampionRoom ...");
  //   try {
  //     box.write(StorageKeys.championRoomKey, jsonEncode(championRoom));
  //     logger.logDEBUG("Success to persist ChampionRoom ...");
  //   } catch (e) {
  //     logger.logDEBUG("Error to persist ChampionRoom ... $e");
  //   }
  // }
  //
  // Future<SpellRoom> getSpellRoomOnWeb() async {
  //   final String path = "/cdn/latest/data/en_US/summoner.json";
  //   SpellRoom spellRoom = SpellRoom();
  //   try{
  //     final response = await httpServices.get(
  //       url: API.riotDragonUrl,
  //       path: path,
  //       origin: origin,
  //     );
  //
  //     return response.fold((l) {
  //       logger.logDEBUG("Error to get SpellRoom");
  //       return spellRoom;
  //     }, (r) {
  //       logger.logDEBUG("Success to get SpellRoom ...");
  //       spellRoom.summonerSpell = SummonerSpell.fromJson(r.data);
  //       return spellRoom;
  //     });
  //   }catch(e){
  //     logger.logDEBUG("Error to get SpellRoom");
  //     return spellRoom;
  //   }
  // }
  //
  // Future<SpellRoom> getSpellRoomOnLocal() async {
  //   logger.logDEBUG("Getting SpellRoom on Local ...");
  //   try {
  //     String spellRoomString = await box.read(StorageKeys.spellRoomKey);
  //     if (spellRoomString.isNotEmpty) {
  //       logger.logDEBUG("Success to get SpellRoom on Local ...");
  //       return SpellRoom.fromJson(jsonDecode(spellRoomString));
  //     }
  //   } catch (e) {
  //     logger.logDEBUG("Error to get SpellRoom on local_imp $e");
  //     return SpellRoom();
  //   }
  //   logger.logDEBUG("SpellRoom on local_imp not found ...");
  //   return SpellRoom();
  // }
  //
  // saveSpellRoom(Map<String, dynamic> spellRoom) {
  //   logger.logDEBUG("Persisting SpellRoom ...");
  //   try {
  //     box.write(StorageKeys.spellRoomKey, jsonEncode(spellRoom));
  //     logger.logDEBUG("Success to persist SpellRoom ...");
  //   } catch (e) {
  //     logger.logDEBUG("Error to persist SpellRoom ... $e");
  //   }
  // }
  //
  // saveMapRoom(Map<String, dynamic> mapRoom) {
  //   logger.logDEBUG("Persisting mapRoom ...");
  //   try {
  //     box.write(StorageKeys.mapRoomKey, jsonEncode(mapRoom));
  //     logger.logDEBUG("Success to persist MapRoom ...");
  //   } catch (e) {
  //     logger.logDEBUG("Error to persist MapRoom ... $e");
  //   }
  // }
  //
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
  // Future<UserFavorite> readFavoriteUsersStoredForCurrentGame() async {
  //   logger.logDEBUG("Reading favorite users stored for current game ...");
  //   try {
  //     String userFavoriteStore =
  //         await box.read(StorageKeys.userFavoriteForCurrentGameKey);
  //     if (userFavoriteStore.isNotEmpty) {
  //       logger.logDEBUG("Success to get userFavorite on Local for current game ...");
  //       return UserFavorite.fromJson(jsonDecode(userFavoriteStore));
  //     }
  //     logger.logDEBUG("No userFavorite persisted found for current game ...");
  //     return UserFavorite();
  //   } catch (e) {
  //     logger.logDEBUG("Error to Read persisted favorite users for current game ... $e");
  //     return UserFavorite();
  //   }
  // }
  //
  // Future<UserFavorite> readFavoriteUsersStoredForProfile() async {
  //   logger.logDEBUG("Reading favorite users stored for profile ...");
  //   try {
  //     String userFavoriteStore =
  //         await box.read(StorageKeys.userFavoriteForProfileKey);
  //     if (userFavoriteStore.isNotEmpty) {
  //       logger.logDEBUG("Success to get userFavorite on Local for profile ...");
  //       return UserFavorite.fromJson(jsonDecode(userFavoriteStore));
  //     }
  //     logger.logDEBUG("No userProfile persisted found for profile ...");
  //     return UserFavorite();
  //   } catch (e) {
  //     logger.logDEBUG("Error to Read persisted favorite users for profile ... $e");
  //     return UserFavorite();
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
  //
  // deleteFavoriteUsersForCurrentGame() {
  //   try {
  //     logger.logDEBUG("deleting favorite users for current game");
  //     box.remove(StorageKeys.userFavoriteForCurrentGameKey);
  //   } catch (e) {
  //     logger.logDEBUG("Error to delete favorite users for current game $e");
  //   }
  // }
  //
  // deleteFavoriteUsersForProfile() {
  //   try {
  //     logger.logDEBUG("deleting favorite users for profile");
  //     box.remove(StorageKeys.userFavoriteForProfileKey);
  //   } catch (e) {
  //     logger.logDEBUG("Error to delete favorite users for profile $e");
  //   }
  // }
  //
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
  //
  // deletePersistedUser() {
  //   try {
  //     logger.logDEBUG("deleting userProfile");
  //     box.remove(StorageKeys.userProfileKey);
  //   } catch (e) {
  //     logger.logDEBUG("Error to delete userProfile $e");
  //   }
  // }
  //
  // Future<StoredRegion> getLastStoredRegion() async {
  //   logger.logDEBUG("Getting LastStoredRegion ...");
  //   StoredRegion storedRegion = StoredRegion();
  //   try {
  //     String lastStoredRegionString = await box.read(StorageKeys.regionKey);
  //     if (lastStoredRegionString.isNotEmpty) {
  //       storedRegion =
  //           StoredRegion.fromJson(jsonDecode(lastStoredRegionString));
  //     }
  //     logger.logDEBUG("Success to get LastStoredRegion ...");
  //     return storedRegion;
  //   } catch (e) {
  //     logger.logDEBUG("Error to get LastStoredRegion $e");
  //     return storedRegion;
  //   }
  // }
  //
  // saveActualRegion(StoredRegion storedRegion) async {
  //   logger.logDEBUG("Saving Actual Region ...");
  //   try {
  //     await box.write(StorageKeys.regionKey, jsonEncode(storedRegion));
  //     logger.logDEBUG("Success to persist Actual Region ...");
  //   } catch (e) {
  //     logger.logDEBUG("Error to save Actual Region $e");
  //   }
  // }
}

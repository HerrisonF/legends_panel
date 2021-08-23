import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/model/userTier.dart';
import 'package:logger/logger.dart';

const PROFILE_KEY = "userProfile";

class ProfileProvider {

  final box = GetStorage('store');

  DioClient _dioClient = DioClient();
  Logger _logger = Logger();

  Future<User> getUserProfile() async {
    _logger.i("Reading persisted UserProfile Url ...");
    User user = User();
    try{
      String user = await box.read(PROFILE_KEY);
      print("HERE> ${User.fromJson(jsonDecode(user)).toString()}");
      return User.fromJson(jsonDecode(user));
    }catch(e){
      _logger.i("Error to Read persisted UserProfile ... $e");
      return user;
    }
  }

  Future<bool> writeUserProfile(User user) async {
    _logger.i("Writing UserProfile ...");
    try{
      await box.write(PROFILE_KEY, jsonEncode(user));
      return true;
    }catch(e){
      _logger.i("Error to write UserProfile ... $e");
      return false;
    }
  }

  Future<User> fetchUser(String userName) async {
    final String path = "/lol/summoner/v4/summoners/by-name/$userName";
    _logger.i("Finding User...");
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        print("HERE> ${User.fromJson(response.result.data)}");
        return User.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error to find User ${e.toString()}");
      return User();
    }
    _logger.i("No user found...");
    return User();
  }

  eraseUser(){
    try{
      _logger.i("Removing user");
      box.remove(PROFILE_KEY);
    }catch(e){
      _logger.i("Error to remove user $e");
    }
  }

  String getProfileImage(String version, String profileIconId){
    final String path = "/cdn/$version/img/profileicon/$profileIconId.png";
    _logger.i("building Image profile Url ...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Profile URL ... $e");
      return "";
    }
  }

  Future<RxList<UserTier>> getUserTier(String encryptedSummonerId) async {
    final String path = "/lol/league/v4/entries/by-summoner/$encryptedSummonerId";
    _logger.i("Getting Summoner Tier");
    try{
      final response = await _dioClient.get(path);
      RxList<UserTier> listTier  = RxList<UserTier>();
      if(response.state == CustomState.SUCCESS){
        if(response.result.data != null){
          for(dynamic tier in response.result.data){
            listTier.add(UserTier.fromJson(tier));
          }
        }
        return listTier;
      }
      _logger.i("UserTier not found ...");
      return listTier;
    }catch(e){
      _logger.i("Error to get UserTier ... $e");
      return RxList<UserTier>();
    }
  }

}
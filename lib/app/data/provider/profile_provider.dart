import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:logger/logger.dart';

class ProfileProvider {

  final box = GetStorage('store');

  DioClient _dioClient = DioClient();
  Logger _logger = Logger();

  Future<User> getUserProfile() async {
    _logger.i("Reading persisted UserProfile Url ...");
    User user = User();
    try{
      final teste = await box.read("userProfile");
      print("OBJ> ${teste}");
      return User.fromJson(teste);
    }catch(e){
      _logger.i("Error to Read persisted UserProfile ... $e");
      return user;
    }
  }

  Future<bool> writeUserProfile(User user) async {
    _logger.i("Writing UserProfile ...");
    try{
      print("OBJ 2> ${user.toJson().toString()}");
      await box.write("userProfile", user.toJson());
      return true;
    }catch(e){
      _logger.i("Error to write UserProfile ... $e");
      return false;
    }
  }

  Future<User> findUser(String userName) async {
    final String path = "/lol/summoner/v4/summoners/by-name/$userName";
    _logger.i("Finding User...");
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return User.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error to find User ${e.toString()}");
      return User();
    }
    _logger.i("No user found...");
    return User();
  }

}
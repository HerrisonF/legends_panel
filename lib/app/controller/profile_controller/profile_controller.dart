import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/sub_controller/participant_controller/participant_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/model/userTier.dart';
import 'package:legends_panel/app/data/repository/profile_repository.dart';

class ProfileController extends UtilController{

  ProfileRepository _profileRepository = ProfileRepository();
  TextEditingController userNameInputController = TextEditingController();
  MasterController _masterController = Get.find<MasterController>();

  Rx<String> buttonMessage = "BUTTON_MESSAGE_SEARCH".tr.obs;

  Rx<User> user = User().obs;
  RxList<UserTier> userTierList = RxList<UserTier>();

  Rx<bool> isLoading = false.obs;

  Rx<bool> isShowingMessage = false.obs;

  startLoading(){
    isLoading(true);
  }

  stopLoading(){
    isLoading(false);
  }

  _showNotFoundMessage(){
    stopLoading();
    isShowingMessage(true);
    buttonMessage("BUTTON_MESSAGE_NOT_FOUND".tr);
    Future.delayed(Duration(seconds: 3)).then((value) {
      buttonMessage("BUTTON_MESSAGE_SEARCH".tr);
      isShowingMessage(false);
    });
  }

  String getLoLVersion(){
    return _masterController.lolVersion.value;
  }

  start() async {
    user.value = await _profileRepository.getUserProfile();
    if(user.value.id.isNotEmpty){
      getUserTierInformation();
    }
    user.refresh();
  }

  findUser() async {
    startLoading();
    user.value = await _profileRepository.fetchUser(userNameInputController.text);
    if(user.value.id.isEmpty){
      _showNotFoundMessage();
    }else{
      _profileRepository.writeProfileUser(user.value);
      getUserTierInformation();
    }
  }

  getUserTierInformation() async {
    userTierList.value = await _profileRepository.getUserTier(user.value.id);
  }

  eraseUser(){
    _profileRepository.eraseUser();
    user.value = User();
  }

  String getProfileImage(){
    return _profileRepository.getProfileImage(_masterController.lolVersion.toString(), user.value.profileIconId.toString());
  }

}
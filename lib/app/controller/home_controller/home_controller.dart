import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/sub_controller/profile_result_sub_controller/profile_result_sub_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/repository/home_repository.dart';
import 'package:legends_panel/app/routes/app_routes.dart';

class HomeController extends GetxController with UtilController {

  final ProfileResultSubController _profileResultSubController = Get.put(ProfileResultSubController());
  final MasterController _masterController = Get.put(MasterController());

  HomeRepository homeRepository = HomeRepository();
  TextEditingController userNameInputController = TextEditingController();

  Rx<String> buttonMessage = "BUTTON_MESSAGE_SEARCH".tr.obs;

  Rx<User> user = User().obs;

  Rx<bool> isLoading = false.obs;

  Rx<bool> isShowingMessage = false.obs;

  startLoading(){
    isLoading(true);
  }

  stopLoading(){
    isLoading(false);
  }

  findUser() async {
    startLoading();
    user.value = await homeRepository.findUser(userNameInputController.text);
    if(user.value.id.isNotEmpty){
      _pushToProfileResult();
    }else{
      _showNotFoundMessage();
    }
  }

  _pushToProfileResult() async {
    if(await _profileResultSubController.existCurrentGame(user.value)){
      _profileResultSubController.setUser(user.value);
      _profileResultSubController.detachParticipantsIntoTeams();
      Get.toNamed(Routes.PROFILE_SUB);
    }else{
      _showNotFoundMessage();
    }
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

}
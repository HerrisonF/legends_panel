import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/repository/profile_repository.dart';

class ProfileController extends UtilController{

  ProfileRepository _profileRepository = ProfileRepository();
  TextEditingController userNameInputController = TextEditingController();
  MasterController _masterController = Get.find<MasterController>();

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
    print("TESTE> ${user.value.toString()}");
  }

  findUser() async {
    bool teste = false;
    startLoading();
    user.value = await _profileRepository.findUser(userNameInputController.text);
    if(user.value.id.isEmpty){
      _showNotFoundMessage();
    }else{
      teste = await _profileRepository.writeProfileUser(user.value);
    }
    print("TESTE> $teste");
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/ui/android/components/region_dropdown_component.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SearchUserProfileComponent extends StatefulWidget {
  const SearchUserProfileComponent({Key? key}) : super(key: key);

  @override
  State<SearchUserProfileComponent> createState() =>
      _SearchUserProfileComponentState();
}

class _SearchUserProfileComponentState
    extends State<SearchUserProfileComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ProfileController _profileController = Get.find<ProfileController>();

  String selectedRegion = 'NA1';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height >
                MasterController.NEXUS_ONE_SCREEN
            ? MediaQuery.of(context).size.width / 12
            : MediaQuery.of(context).size.width / 15,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.5),
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
        image: DecorationImage(
          image: AssetImage(imageBackgroundProfilePengu),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _inputSummonerName(),
          _buttonSearchSummoner(),
          RegionDropDownComponent(
            onRegionChoose: (region) {
              setState(() {
                this.selectedRegion = region;
              });
            },
          ),
        ],
      ),
    );
  }

  Container _buttonSearchSummoner() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height >
                MasterController.NEXUS_ONE_SCREEN
            ? MediaQuery.of(context).size.width / 13.5
            : MediaQuery.of(context).size.width / 11,
      ),
      width: MediaQuery.of(context).size.width,
      height:
          MediaQuery.of(context).size.height > MasterController.NEXUS_ONE_SCREEN
              ? MediaQuery.of(context).size.height / 18
              : MediaQuery.of(context).size.height / 13,
      child: Obx(
        () {
          return OutlinedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _profileController.buttonMessage.value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _profileController.isUserLoading.value
                    ? JumpingDotsProgressIndicator(
                        fontSize: 22,
                        color: Colors.white,
                      )
                    : SizedBox.shrink()
              ],
            ),
            onPressed: _profileController.isShowingMessage.value
                ? null
                : () {
                    _searchForUserOnCloud();
                  },
          );
        },
      ),
    );
  }

  Container _inputSummonerName() {
    return Container(
      child: Form(
        key: formKey,
        child: Obx((){
          return TextFormField(
            enabled: !_profileController.isUserLoading.value,
            controller: _profileController.userNameInputController,
            decoration: InputDecoration(
              hintText: "HINT_SUMMONER_NAME".tr,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                _profileController.userNameInputController.clear();
                return "INPUT_VALIDATOR_HOME".tr;
              }
              if (selectedRegion.isEmpty) {
                _profileController.userNameInputController.clear();
                return "INPUT_VALIDATOR_HOME".tr;
              }
              return null;
            },
          );
        }),
      ),
    );
  }

  _searchForUserOnCloud() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _profileController.getUserOnCloud(selectedRegion);
    }
  }
}

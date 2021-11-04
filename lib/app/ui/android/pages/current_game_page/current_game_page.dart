import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/current_game_controller/current_game_controller.dart';
import 'package:legends_panel/app/ui/android/components/region_dropdown_component.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CurrentGamePage extends StatefulWidget {
  @override
  State<CurrentGamePage> createState() => _CurrentGamePageState();
}

class _CurrentGamePageState extends State<CurrentGamePage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CurrentGameController _currentGameController =
      Get.put(CurrentGameController());

  String selectedRegion = 'NA1';

  @override
  Widget build(BuildContext context) {
    return Container(
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
            image: AssetImage(imageBackgroundCurrentGame), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _inputSummonerName(),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: _searchForSummonerButton(context)),
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

  Container _searchForSummonerButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Obx(
        () {
          return OutlinedButton(
            child: _currentGameController.isLoadingUser.value
                ? JumpingDotsProgressIndicator(
                    fontSize: 30,
                    color: Colors.white,
                  )
                : Text(
                    _currentGameController.buttonMessage.value,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2),
                  ),
            onPressed: _currentGameController.isShowingMessage.value
                ? null
                : () {
                    _submit();
                  },
          );
        },
      ),
    );
  }

  Container _inputSummonerName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: formKey,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "HINT_SUMMONER_NAME".tr,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          controller: _currentGameController.userNameInputController,
          onFieldSubmitted: (value) {
            _submit();
          },
          validator: (value) {
            if (value!.trim().isEmpty) {
              _currentGameController.userNameInputController.clear();
              return "INPUT_VALIDATOR_HOME".tr;
            }
            return null;
          },
        ),
      ),
    );
  }

  _submit() {
    if (formKey.currentState!.validate()) {
      _currentGameController.getUserFromCloud(selectedRegion);
    }
  }
}

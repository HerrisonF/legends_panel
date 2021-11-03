import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/current_game_controller/current_game_controller.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CurrentGamePage extends StatefulWidget {
  @override
  State<CurrentGamePage> createState() => _CurrentGamePageState();
}

class _CurrentGamePageState extends State<CurrentGamePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CurrentGameController _currentGameController =
      Get.put(CurrentGameController());

  List<String> _locations = [
    'BR1',
    'EUN1',
    'EUW1',
    'JP1',
    'KR',
    'LA1',
    'LA2',
    'NA1',
    'OC1',
    'TR1',
    'RU'
  ]; // Option 2
  String _selectedLocation = 'BR1';

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
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _inputSummonerName(),
            Container(
                margin: EdgeInsets.only(top: 40),
                child: _searchForSummonerButton(context)),
            //_dropDownRegion(),
          ],
        ),
      ),
    );
  }

  Container _dropDownRegion() {
    return Container(
      child: DropdownButton(
        hint: Text('Please choose a location'),
        value: _selectedLocation,
        onChanged: (newValue) {
          setState(() {
            _selectedLocation = newValue.toString();
          });
        },
        items: _locations.map((location) {
          return DropdownMenuItem(
            child: new Text(location),
            value: location,
          );
        }).toList(),
      ),
    );
  }

  Container _searchForSummonerButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: Obx(
        () {
          return _currentGameController.isLoadingUser.value
              ? JumpingDotsProgressIndicator(
                  fontSize: 30,
                  color: Colors.white,
                )
              : OutlinedButton(
                  child: Text(
                    _currentGameController.buttonMessage.value,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
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
      _currentGameController.getUserFromCloud();
    }
  }
}

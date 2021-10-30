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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Form(
              key: formKey,
              child: TextFormField(
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
          ),
          Container(
            child: Obx(
              () {
                return _currentGameController.isLoadingUser.value
                    ? JumpingDotsProgressIndicator(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      )
                    : OutlinedButton(
                        child: Text(_currentGameController.buttonMessage.value),
                        onPressed: _currentGameController.isShowingMessage.value
                            ? null
                            : () {
                                _submit();
                              },
                      );
              },
            ),
          ),
          // Container(
          //   child: DropdownButton(
          //     hint: Text('Please choose a location'),
          //     value: _selectedLocation,
          //     onChanged: (newValue) {
          //       setState(() {
          //         _selectedLocation = newValue.toString();
          //       });
          //     },
          //     items: _locations.map((location) {
          //       return DropdownMenuItem(
          //         child: new Text(location),
          //         value: location,
          //       );
          //     }).toList(),
          //   ),
          // ),
          Container(
            child: Text(
              _currentGameController.getLoLVersion(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _submit() {
    if (formKey.currentState!.validate()) {
      _currentGameController.getUserFromCloud();
    }
  }
}

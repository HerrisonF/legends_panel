import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/current_game_controller/current_game_controller.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CurrentGamePage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CurrentGameController _currentGameController =
      Get.put(CurrentGameController());

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
                return _currentGameController.isLoading.value
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

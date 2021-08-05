import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/home_controller/home_controller.dart';
import 'package:progress_indicators/progress_indicators.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HomeController _homeController = Get.put(HomeController());

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
                controller: _homeController.userNameInputController,
                onFieldSubmitted: (value) {
                  _submit();
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    _homeController.userNameInputController.clear();
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
                return _homeController.isLoading.value
                    ? JumpingDotsProgressIndicator(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      )
                    : OutlinedButton(
                        child: Text(_homeController.buttonMessage.value),
                        onPressed: _homeController.isShowingMessage.value ? null : () {
                          _submit();
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  _submit() {
    _homeController.closeKeyBoard(context);
    if (formKey.currentState!.validate()) {
      _homeController.findUser();
    }
  }
}

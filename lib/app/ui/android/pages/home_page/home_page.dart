import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/home_controller/home_controller.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child:Form(
              key: formKey,
              child: TextFormField(
                controller: _homeController.userNameInputController,
                onFieldSubmitted: (value){
                  print("SUBMITADO");
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "INPUT_VALIDATOR_HOME".tr;
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            child: OutlinedButton(
              child: Text("Procurar"),
              onPressed: (){
                _homeController.closeKeyBoard(context);
                _homeController.findUser();
                formKey.currentState!.validate();
              },
            ),
          ),
        ],
      ),
    );
  }
}

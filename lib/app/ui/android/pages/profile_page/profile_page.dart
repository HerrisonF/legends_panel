import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = Get.put(ProfileController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _profileController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _profileController.user.value.id.isNotEmpty ? profile() : field();
    });
  }

  field() {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: _profileController.userNameInputController,
                  onFieldSubmitted: (value) {
                    _submit();
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      _profileController.userNameInputController.clear();
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
                  return _profileController.isLoading.value
                      ? JumpingDotsProgressIndicator(
                          fontSize: 30,
                          color: Theme.of(context).primaryColor,
                        )
                      : OutlinedButton(
                          child: Text(_profileController.buttonMessage.value),
                          onPressed: _profileController.isShowingMessage.value
                              ? null
                              : () {
                                  _submit();
                                },
                        );
                },
              ),
            ),
            Obx(() {
              return Container(
                child: Text(
                  _profileController.getLoLVersion(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  _submit() {
    _profileController.closeKeyBoard(context);
    if (formKey.currentState!.validate()) {
      _profileController.findUser();
    }
  }

  Widget profile() {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).backgroundColor.withOpacity(0.9),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: foundSummoner(context),
            ),
            Container(
              child: Container(
                height: 100,
                color: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: (){
                    _profileController.eraseUser();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.greenAccent,
                    child: Row(
                      children: [
                        Container(
                          child: Text("IMG"),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text("F"),
                            ),
                            Container(
                              child: Text("I"),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text("PA"),
                            ),
                            Container(
                              child: Text("PB"),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text("I1"),
                                ),
                                Container(
                                  child: Text("I2"),
                                ),
                                Container(
                                  child: Text("I3"),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text("I4"),
                                ),
                                Container(
                                  child: Text("I5"),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          child: Text("Role"),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text("Frag"),
                            ),
                            Container(
                              child: Text("map Type"),
                            ),
                            Container(
                              child: Text("time ago"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget foundSummoner(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(250, 90),
              bottomRight: Radius.elliptical(250, 90)),
          child: Container(
            color: Colors.amber,
            height: MediaQuery.of(context).size.height / 3.5,
          ),
        ),
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        _profileController.getProfileImage()
                    ),
                  ),
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(50, 60),
                    bottomRight: Radius.elliptical(50, 60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 6.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx((){
                return Container(
                  child: Text(
                    _profileController.user.value.name,
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                );
              })
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    child: Text("Brasil"),
                  ),
                  Obx((){
                    return Container(
                      child: Text("Nível ${_profileController.user.value.summonerLevel}"),
                    );
                  })
                ],
              ),
              Column(
                children: [
                  Container(
                    child: Text("Vitórias"),
                  ),
                  Container(
                    child: Text(_profileController.userTierList.first.wins.toString()),
                  ),
                  Container(
                    child: Text("Derrotas"),
                  ),
                  Container(
                    child: Text(_profileController.userTierList.first.losses.toString()),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 4.5,
          left: MediaQuery.of(context).size.width / 2.5,
          child: Container(
            height: 80,
            width: 80,
            child: Obx((){
              return Container(
                child: Image.asset("images/emblem_${_profileController.userTierList.first.tier.toLowerCase()}.png")
              );
            }),
          ),
        ),
      ],
    );
  }
}

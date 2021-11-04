import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';
import 'package:legends_panel/app/ui/android/components/region_dropdown_component.dart';
import 'package:legends_panel/app/ui/android/pages/profile_page/item_match_list_game_card.dart';
import 'package:legends_panel/app/ui/android/pages/profile_page/mastery_champions.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController =
      Get.put(ProfileController(), permanent: true);
  final MasterController _masterController = Get.find<MasterController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  String selectedRegion = 'NA1';

  @override
  void initState() {
    _profileController.startProfileController(selectedRegion);
    this._scrollController.addListener(this._scrollListenerFunction);
    super.initState();
  }

  @override
  void dispose() {
    this._scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return _profileController.isUserLoading.value
              ? DotsLoading()
              : _masterController.userProfile.value.id.isNotEmpty
                  ? foundUserProfile()
                  : searchUserFieldContent();
        },
      ),
    );
  }

  searchUserFieldContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
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
      margin: EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Obx(
        () {
          return OutlinedButton(
            child: _profileController.isUserLoading.value
                ? JumpingDotsProgressIndicator(
                    fontSize: 30,
                    color: Colors.white,
                  )
                : Text(
                    _profileController.buttonMessage.value,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2),
                  ),
            onPressed: _profileController.isShowingMessage.value
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
          controller: _profileController.userNameInputController,
          decoration: InputDecoration(
            hintText: "HINT_SUMMONER_NAME".tr,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onFieldSubmitted: (value) {
            _submit();
          },
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
        ),
      ),
    );
  }

  _submit() {
    if (formKey.currentState!.validate()) {
      _profileController.getUserOnCloud(selectedRegion);
    }
  }

  Widget foundUserProfile() {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).backgroundColor.withOpacity(0.9),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: summonerPanel(context),
            ),
            MasteryChampions(),
            Obx(() {
              return _profileController.matchList.length > 0
                  ? Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: _hasMoreMatchesToLoad(),
                        controller: this._scrollController,
                        itemBuilder: (_, myCurrentPosition) {
                          return _isLoadingGameCard(myCurrentPosition);
                        },
                      ),
                    )
                  : DotsLoading();
            }),
          ],
        ),
      ),
    );
  }

  _scrollListenerFunction() {
    Future.delayed(Duration(milliseconds: 200)).then(
      (_) {
        if (isUserScrollingDown() &&
            (this._profileController.newIndex ==
                this._profileController.oldIndex)) {
          this._profileController.loadMoreMatches(selectedRegion);
        }
      },
    );
  }

  bool isUserScrollingDown() {
    return (this._scrollController.offset * 2) >=
            this._scrollController.position.maxScrollExtent &&
        !this._scrollController.position.outOfRange;
  }

  int _hasMoreMatchesToLoad() {
    if (_profileController.lockNewLoadings.value) {
      return _profileController.matchList.length;
    }
    if (_profileController.isLoadingNewMatches.value) {
      return _profileController.matchList.length + 1;
    }
    return _profileController.matchList.length;
  }

  Widget _isLoadingGameCard(int myCurrentPosition) {
    if (myCurrentPosition < this._profileController.matchList.length) {
      return ItemMatchListGameCard(
          _profileController.matchList[myCurrentPosition]);
    } else {
      return Container(
        padding: EdgeInsets.all(50),
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
  }

  Widget summonerPanel(BuildContext context) {
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
                    image:
                        NetworkImage(_profileController.getUserProfileImage()),
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
              Obx(() {
                return Container(
                  child: Text(
                    _masterController.userProfile.value.name,
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
                  Obx(() {
                    return Container(
                      child: Text(
                          "Nível ${_masterController.userProfile.value.summonerLevel}"),
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
                    child: Text(
                        _profileController.userTierList.first.wins.toString()),
                  ),
                  Container(
                    child: Text("Derrotas"),
                  ),
                  Container(
                    child: Text(_profileController.userTierList.first.losses
                        .toString()),
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
            child: Obx(() {
              return Container(
                  child: Image.asset(
                      "images/emblem_${_profileController.userTierList.first.tier.toLowerCase()}.png"));
            }),
          ),
        ),
      ],
    );
  }
}

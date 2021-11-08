import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
    _profileController.startProfileController();
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
          return _masterController.userProfile.value.id.isEmpty ||
                  _profileController.isUserLoading.value
              ? searchUserFieldContent()
              : foundUserProfile();
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
      FocusScope.of(context).unfocus();
      _profileController.getUserOnCloud(selectedRegion);
    }
  }

  Widget foundUserProfile() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imageBackgroundProfilePage), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.55,
            child: summonerPanel(context),
          ),
          MasteryChampions(),
          Obx(() {
            return _masterController.userProfile.value.name != ""
                ? _outButton()
                : SizedBox.shrink();
          }),
          Obx(() {
            return _profileController.matchList.length > 0
                ? Expanded(
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
    );
  }

  Container _outButton() {
    return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.black26,
                  ),
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(bottom: 25),
                  child: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      goToProfile();
                    },
                  ),
                );
  }

  goToProfile() {
    _profileController.deletePersistedUser();
    _masterController.changeCurrentPageIndex(1);
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
      return JumpingDotsProgressIndicator(
        color: Colors.white,
        fontSize: 20,
      );
    }
  }

  Widget summonerPanel(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(
                  Rect.fromLTRB(0, 60, rect.width, rect.height - 40));
            },
            blendMode: BlendMode.dstIn,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(
                    MediaQuery.of(context).size.width / 2, 70),
                bottomRight: Radius.elliptical(
                    MediaQuery.of(context).size.width / 2, 70),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        _profileController.getChampionImage(
                          _profileController.championMasteryList[0].championId,
                        ),
                      ),
                      fit: BoxFit.fill,
                      colorFilter:
                          ColorFilter.mode(Colors.black26, BlendMode.overlay)),
                ),
              ),
            ),
          ),
        ),
        _profileImage(),
        _profileName(context),
        _profileStatistics(),
        _playerEloEmblem(context),
      ],
    );
  }

  Positioned _playerEloEmblem(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 4.3,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 115,
            width: 115,
            child: Obx(() {
              return Container(
                  child: Image.asset(
                      "images/emblem_${_profileController.userTierList.first.tier.toLowerCase()}.png"));
            }),
          ),
        ],
      ),
    );
  }

  Container _profileStatistics() {
    return Container(
      margin: EdgeInsets.only(top: 70, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Obx(() {
                return Container(
                  margin: EdgeInsets.only(top: 55),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(1.0, 0.0),
                        blurRadius: 25)
                  ]),
                  child: Text(
                    "LEVEL".tr +
                        " ${_masterController.userProfile.value.summonerLevel}",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                );
              })
            ],
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(1.0, 0.0),
                      blurRadius: 25)
                ]),
                child: Text(
                  'VICTORY'.tr,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              Container(
                child: Text(
                    _profileController.userTierList.first.wins.toString(),
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
              ),
              Container(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(1.0, 0.0),
                      blurRadius: 25)
                ]),
                child: Text('LOSE'.tr,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ),
              Container(
                child: Text(
                    _profileController.userTierList.first.losses.toString(),
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
              )
            ],
          )
        ],
      ),
    );
  }

  Positioned _profileName(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 5.5,
      left: 0,
      right: 0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return Stack(
                children: [
                  Positioned(
                    child: Container(
                      child: Text(
                        _masterController.userProfile.value.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 1,
                    child: Container(
                      child: Text(
                        _masterController.userProfile.value.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  SafeArea _profileImage() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_profileController.getUserProfileImage()),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(50, 60),
                bottomRight: Radius.elliptical(50, 60),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

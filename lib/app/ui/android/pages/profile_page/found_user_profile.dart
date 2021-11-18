import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'item_match_list_game_card.dart';
import 'mastery_champions.dart';

class FoundUserComponent extends StatefulWidget {
  const FoundUserComponent({Key? key}) : super(key: key);

  @override
  State<FoundUserComponent> createState() => _FoundUserComponentState();
}

class _FoundUserComponentState extends State<FoundUserComponent> {
  final ScrollController _scrollController = ScrollController();
  final ProfileController _profileController =
      Get.put(ProfileController(), permanent: true);
  final MasterController _masterController = Get.find<MasterController>();

  @override
  void initState() {
    this._scrollController.addListener(this._scrollListenerFunction);
    super.initState();
  }

  @override
  void dispose() {
    this._scrollController.dispose();
    super.dispose();
  }

  _scrollListenerFunction() {
    Future.delayed(Duration(milliseconds: 200)).then(
      (_) {
        if (isUserScrollingDown() &&
            (this._profileController.newIndex ==
                this._profileController.oldIndex)) {
          this
              ._profileController
              .loadMoreMatches(_masterController.userProfile.value.region);
        }
      },
    );
  }

  bool isUserScrollingDown() {
    return (this._scrollController.offset * 2) >=
            this._scrollController.position.maxScrollExtent &&
        !this._scrollController.position.outOfRange;
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            margin: EdgeInsets.only(top: 15),
            child: MasteryChampions(),
          ),
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
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        color: Colors.black26,
      ),
      height:
          MediaQuery.of(context).size.height > MasterController.NEXUS_ONE_SCREEN
              ? MediaQuery.of(context).size.height / 17
              : MediaQuery.of(context).size.height / 14,
      width: MediaQuery.of(context).size.width / 8,
      child: IconButton(
        icon: Icon(
          Icons.exit_to_app,
          color: Colors.white,
          size: MediaQuery.of(context).size.height >
                  MasterController.NEXUS_ONE_SCREEN
              ? 22
              : 15,
        ),
        onPressed: () {
          goToProfile();
        },
      ),
    );
  }

  goToProfile() {
    _profileController.deletePersistedUser();
    _profileController.changeCurrentProfilePage(0);
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
          child: Obx(() {
            return ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(
                  Rect.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height / 11,
                      rect.width,
                      rect.height - MediaQuery.of(context).size.height / 11),
                );
              },
              blendMode: BlendMode.dstIn,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                      MediaQuery.of(context).size.width / 2, 70),
                  bottomRight: Radius.elliptical(
                      MediaQuery.of(context).size.width / 2, 70),
                ),
                child: _profileController.championMasteryList.isNotEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              _profileController.getChampionImage(
                                _profileController
                                    .championMasteryList[0].championId,
                              ),
                            ),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.black26, BlendMode.overlay),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            );
          }),
        ),
        _profileController.getUserProfileImage() != ""
            ? _profileImage()
            : SizedBox.shrink(),
        _masterController.userProfile.value.name != ""
            ? _profileName(context)
            : SizedBox.shrink(),
        _masterController.userProfile.value.summonerLevel != "" &&
                _profileController.userTierList.length > 0
            ? _profileStatistics()
            : SizedBox.shrink(),
        _profileController.userTierList.length > 0
            ? _playerEloEmblem(context)
            : SizedBox.shrink(),
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
            height: MediaQuery.of(context).size.height / 6.5,
            width: MediaQuery.of(context).size.width / 4,
            child: Image.asset(
                "images/emblem_${_profileController.userTierList.first.tier.toLowerCase()}.png"),
          ),
        ],
      ),
    );
  }

  Container _profileStatistics() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 10,
          left: MediaQuery.of(context).size.width / 10,
          right: MediaQuery.of(context).size.width / 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Obx(() {
                return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 10),
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
                        fontSize: 11),
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
                      fontSize: 11),
                ),
              ),
              Container(
                child: Text(
                  _profileController.userTierList.first.wins.toString(),
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11),
                ),
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
                child: Text(
                  'LOSE'.tr,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
              Container(
                child: Text(
                  _profileController.userTierList.first.losses.toString(),
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
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
                          fontSize: 18,
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
                          fontSize: 18,
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
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 45),
            width: MediaQuery.of(context).size.height >
                    MasterController.NEXUS_ONE_SCREEN
                ? MediaQuery.of(context).size.width / 5
                : MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 11,
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
                  blurRadius: 5,
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

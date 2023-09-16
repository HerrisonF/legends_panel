import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/core/utils/screen_utils.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';

import 'item_match_list_game_card.dart';
import 'mastery_champions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FoundUserComponent extends StatefulWidget {
  const FoundUserComponent({Key? key}) : super(key: key);

  @override
  State<FoundUserComponent> createState() => _FoundUserComponentState();
}

class _FoundUserComponentState extends State<FoundUserComponent> {
  final ScrollController _scrollController = ScrollController();
  final ProfileController _profileController = GetIt.I<ProfileController>();
  final MasterController _masterController = GetIt.I<MasterController>();

  @override
  void initState() {
    // _masterController.addUserToFavoriteProfileList(
    //     _profileController.userTierRankedSolo.value.tier);
    this._scrollController.addListener(this._scrollListenerFunction);
    super.initState();
  }

  @override
  void dispose() {
    this._scrollController.removeListener(this._scrollListenerFunction);
    this._scrollController.dispose();
    super.dispose();
  }

  _scrollListenerFunction() {
    if (isUserScrollingDown() &&
        (this._profileController.newIndex ==
            this._profileController.oldIndex)) {
      this
          ._profileController
          .loadMoreMatches(_masterController.userForProfile.region);
    }
  }

  bool isUserScrollingDown() {
    return (this._scrollController.offset * 1.3) >=
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
          Stack(
            children: [
              Container(
                height: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                    ? MediaQuery.of(context).size.height / 3
                    : MediaQuery.of(context).size.height / 2.8,
                child: summonerPanel(context),
              ),
              Positioned(
                left: 25,
                top:
                    ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 20 : 25,
                child: _outButton(),
              ),
            ],
          ),
          MasteryChampions(),
          ValueListenableBuilder(
              valueListenable: _profileController.matchList,
              builder: (context, value, _) {
                return _profileController.matchList.value.length > 0
                    ? Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 45),
                          child: ListView.builder(
                            itemCount: _hasMoreMatchesToLoad(),
                            controller: this._scrollController,
                            itemBuilder: (_, myCurrentPosition) {
                              return _isLoadingGameCard(myCurrentPosition);
                            },
                          ),
                        ),
                      )
                    : DotsLoading();
              }),
        ],
      ),
    );
  }

  Widget _isLoadingGameCard(int myCurrentPosition) {
    if (myCurrentPosition < this._profileController.matchList.value.length) {
      return ItemMatchListGameCard(
          _profileController.matchList.value[myCurrentPosition]);
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        margin: EdgeInsets.only(bottom: 30),
        child: DotsLoading(),
      );
    }
  }

  _outButton() {
    return IconButton(
      icon: Icon(
        Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        color: Colors.white,
        size: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 20 : 14,
      ),
      onPressed: () {
        goToProfile();
      },
    );
  }

  goToProfile() {
    _profileController.deletePersistedUser();
    _profileController.isUserFound.value = false;
    _profileController.changeCurrentProfilePageTo(
        ProfileController.SEARCH_USER_PROFILE_COMPONENT);
  }

  int _hasMoreMatchesToLoad() {
    if (_profileController.lockNewLoadings.value) {
      return _profileController.matchList.value.length;
    }
    if (_profileController.isLoadingNewMatches.value) {
      return _profileController.matchList.value.length + 1;
    }
    return _profileController.matchList.value.length;
  }

  Widget summonerPanel(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
              valueListenable: _profileController.championMasteryList,
              builder: (context, value, _) {
                return ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(
                          MediaQuery.of(context).size.width / 2, 0),
                      bottomRight: Radius.elliptical(
                          MediaQuery.of(context).size.width / 3, 100),
                    ),
                    child:
                        _profileController.championMasteryList.value.isNotEmpty
                            ? Container(
                                height: MediaQuery.of(context).size.height / 4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _profileController.getChampionImage(
                                        _profileController.championMasteryList
                                            .value[0].championId,
                                      ),
                                    ),
                                    fit: BoxFit.cover,
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
        _masterController.userForProfile.name != ""
            ? _profileName(context)
            : SizedBox.shrink(),
        _masterController.userForProfile.summonerLevel != "" &&
                _profileController.userTierList.value.length > 0
            ? _profileStatistics()
            : SizedBox.shrink(),
        _playerRankedEloEmblem(context),
      ],
    );
  }

  Positioned _playerRankedEloEmblem(BuildContext context) {
    return Positioned(
      top: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
          ? MediaQuery.of(context).size.height / 5
          : MediaQuery.of(context).size.height / 4.5,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: _profileController.userTierRankedSolo,
            builder: (context, value, _) {
              return Container(
                height: MediaQuery.of(context).size.height / 8,
                child:
                    _profileController.userTierRankedSolo.value.tier.isNotEmpty
                        ? Image.asset(
                            "images/emblem_${_profileController.userTierRankedSolo.value.tier.toLowerCase()}.png",
                          )
                        : SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }

  Container _profileStatistics() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
              ? MediaQuery.of(context).size.height / 14
              : MediaQuery.of(context).size.height / 12,
          left: MediaQuery.of(context).size.width / 10,
          right: MediaQuery.of(context).size.width / 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 20),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(1.0, 0.0),
                      blurRadius: 25)
                ]),
                child: Text(
                  AppLocalizations.of(context)!.level +
                      " ${_masterController.userForProfile.summonerLevel}",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize:
                          ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                              ? 12
                              : 10),
                ),
              )
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
                  AppLocalizations.of(context)!.victory,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize:
                          ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                              ? 12
                              : 10),
                ),
              ),
              Container(
                child: Text(
                  _profileController.userTierRankedSolo.value.wins.toString(),
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize:
                          ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                              ? 12
                              : 10),
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
                  AppLocalizations.of(context)!.lose,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                        ? 12
                        : 10,
                  ),
                ),
              ),
              Container(
                child: Text(
                  _profileController.userTierRankedSolo.value.losses.toString(),
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                        ? 12
                        : 10,
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
      top: MediaQuery.of(context).size.height / 6.3,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  child: Text(
                    _masterController.userForProfile.name,
                    style: GoogleFonts.montserrat(
                      fontSize:
                          ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                              ? 18
                              : 12,
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
                    _masterController.userForProfile.name,
                    style: GoogleFonts.montserrat(
                      fontSize:
                          ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                              ? 18
                              : 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  SafeArea _profileImage() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 5 : 15,
            ),
            width: 50,
            height: 50,
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

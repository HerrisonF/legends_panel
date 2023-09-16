import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/current_game_controller/current_game_controller.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/core/utils/screen_utils.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';
import 'package:legends_panel/app/ui/android/components/header_screen_information.dart';
import 'package:legends_panel/app/ui/android/components/region_dropdown_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../layers/presentation/util_controllers/util_controller.dart';

class CurrentGamePage extends StatefulWidget {
  @override
  State<CurrentGamePage> createState() => _CurrentGamePageState();
}

class _CurrentGamePageState extends State<CurrentGamePage> {
  final GlobalKey<FormState> currentGameUserFormKey = GlobalKey<FormState>();

  final CurrentGameController _currentGameController =
      GetIt.I<CurrentGameController>();

  final MasterController _masterController = GetIt.I<MasterController>();

  String initialRegion = '';

  @override
  void initState() {
    getLastStoredRegionForCurrentGame();
    super.initState();
  }

  getLastStoredRegionForCurrentGame() {
    String receivedRegion =
        _currentGameController.getLastStoredRegionForCurrentGame();
    initialRegion = receivedRegion;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          Container(decoration: _currentGameBackgroundImage()),
          ListView(
            children: [
              HeaderScreenInformation(
                  title: AppLocalizations.of(context)!.titleCurrentGamePage,
                  topSpace: 40,
                  bottomSpace: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                      ? 100
                      : 30),
              _summonerSearch(),
              // Container(
              //   alignment: Alignment.center,
              //   height: 50,
              //   margin: EdgeInsets.only(top: 35, bottom: 90),
              //   child: _mostSearchedPlayers(),
              // )
            ],
          ),
        ],
      ),
    );
  }

  _summonerSearch() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 40 : 25,
          ),
          child: _inputForSummonerName(),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 40 : 25,
          ),
          child: _buttonForSearchSummoner(),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 40 : 25,
          ),
          child: ValueListenableBuilder(
            valueListenable: _currentGameController.isLoadingUser,
            builder: (context, value, _) {
              return RegionDropDownComponent(
                initialRegion: initialRegion,
                onRegionChoose: (region) {
                  setState(
                    () {
                      _currentGameController.setAndSaveActualRegion(region);
                    },
                  );
                },
                isLoading: _currentGameController.isLoadingUser.value,
              );
            },
          ),
        ),
      ],
    );
  }

  BoxDecoration _currentGameBackgroundImage() {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      image: DecorationImage(
        image: AssetImage(imageBackgroundCurrentGame),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColor.withOpacity(0.8), BlendMode.plus),
      ),
    );
  }

  _inputForSummonerName() {
    return Form(
      key: currentGameUserFormKey,
      child: ValueListenableBuilder(
          valueListenable: _currentGameController.isLoadingUser,
          builder: (context, value, _) {
            return TextFormField(
              enabled: !_currentGameController.isLoadingUser.value,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.hintSummonerName,
                hintStyle: TextStyle(
                  fontSize: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                      ? 16
                      : 12,
                ),
                errorStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              controller: _currentGameController.userNameInputController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  _currentGameController.userNameInputController.clear();
                  return AppLocalizations.of(context)!.inputValidatorHome;
                }
                return null;
              },
            );
          }),
    );
  }

  Container _buttonForSearchSummoner() {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical:
              ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 45 : 15),
      height: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 54 : 45,
      child: ValueListenableBuilder(
          valueListenable: _currentGameController.isLoadingUser,
          builder: (context, value, _) {
            return OutlinedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _whichMessageShowToUser(),
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize:
                          ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                              ? 15
                              : 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (_currentGameController.isLoadingUser.value) DotsLoading()
                ],
              ),
              onPressed: _currentGameController.isShowingMessage.value
                  ? null
                  : () {
                      _validateAndSearchSummoner();
                    },
            );
          }),
    );
  }

  // _mostSearchedPlayers() {
  //   return ValueListenableBuilder(
  //     valueListenable: _masterController.favoriteUsersForCurrentGame,
  //     builder: (context, value, _) =>
  //         _masterController.favoriteUsersForCurrentGame.value.length > 0
  //             ? ListView.builder(
  //                 padding: EdgeInsets.zero,
  //                 itemCount: _masterController
  //                     .favoriteUsersForCurrentGame.value.length,
  //                 scrollDirection: Axis.horizontal,
  //                 shrinkWrap: true,
  //                 itemBuilder: (context, index) {
  //                   return _favoritePlayerCard(context, index);
  //                 },
  //               )
  //             : _favoriteUserBoardInformation(),
  //   );
  // }

  // _favoritePlayerCard(BuildContext context, int index) {
  //   return Container(
  //     width: 150,
  //     margin: EdgeInsets.only(left: 10, right: 10),
  //     padding: EdgeInsets.only(left: 10),
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).backgroundColor,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: ValueListenableBuilder(
  //         valueListenable: _currentGameController.isLoadingUser,
  //         builder: (context, value, _) {
  //           return Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               InkWell(
  //                 onTap: _currentGameController.isLoadingUser.value
  //                     ? null
  //                     : () {
  //                         _currentGameController.userNameInputController.text =
  //                             _masterController.favoriteUsersForCurrentGame
  //                                 .value[index].name;
  //                       },
  //                 child: Container(
  //                   height: 60,
  //                   color: Theme.of(context).backgroundColor,
  //                   child: Row(
  //                     children: [
  //                       Container(
  //                         width: 70,
  //                         child: Text(
  //                           _masterController
  //                               .favoriteUsersForCurrentGame.value[index].name,
  //                           maxLines: 2,
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         child: _masterController.favoriteUsersForCurrentGame
  //                                 .value[index].userTier.isNotEmpty
  //                             ? Image.asset(
  //                                 _masterController.getUserTierImage(
  //                                   _masterController
  //                                       .favoriteUsersForCurrentGame
  //                                       .value[index]
  //                                       .userTier,
  //                                 ),
  //                                 width: 17,
  //                               )
  //                             : Container(
  //                                 margin: EdgeInsets.only(left: 5),
  //                                 child: Image.asset(
  //                                   imageUnranked,
  //                                   width: 17,
  //                                 ),
  //                               ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   _masterController.removeFavoriteUserForCurrentGame(index);
  //                 },
  //                 child: Container(
  //                   height: 60,
  //                   width: 43,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.only(
  //                         topRight: Radius.circular(8),
  //                         bottomRight: Radius.circular(8)),
  //                     color: Colors.white,
  //                   ),
  //                   child: Container(
  //                     child: Icon(
  //                       Icons.delete,
  //                       size: 20,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         }),
  //   );
  // }
  //
  // _favoriteUserBoardInformation() {
  //   return Container(
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Container(
  //           height: 50,
  //           color: Theme.of(context).backgroundColor.withOpacity(0.2),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(bottom: 5),
  //           child: Text(
  //             AppLocalizations.of(context)!.favoriteUsers,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w600,
  //               fontSize: 16,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  String _whichMessageShowToUser() {
    return _currentGameController.isLoadingUser.value
        ? AppLocalizations.of(context)!.searching
        : _currentGameController.isShowingMessage.value
            ? AppLocalizations.of(context)!.buttonMessageUserNotFound
            : _currentGameController.isShowingMessageUserIsNotPlaying.value
                ? AppLocalizations.of(context)!.buttonMessageGameNotFound
                : AppLocalizations.of(context)!.buttonMessageSearch;
  }

  _validateAndSearchSummoner() {
    if (currentGameUserFormKey.currentState!.validate()) {
      UtilController.closeKeyBoard(context);
      _currentGameController.processCurrentGame(context);
    }
  }
}

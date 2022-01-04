import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/current_game_controller/current_game_controller.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';
import 'package:legends_panel/app/ui/android/components/region_dropdown_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentGamePage extends StatefulWidget {
  @override
  State<CurrentGamePage> createState() => _CurrentGamePageState();
}

class _CurrentGamePageState extends State<CurrentGamePage> {
  final GlobalKey<FormState> currentGameUserFormKey = GlobalKey<FormState>();

  final CurrentGameController _currentGameController =
      Get.put(CurrentGameController());

  final MasterController _masterController = Get.find<MasterController>();

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
      color:  Theme.of(context).primaryColor,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            decoration: _currentGameBackgroundImage(),
          ),
          Column(
            children: [
              Expanded(
                flex: 3,
                child: _screenInformation(),
              ),
              Expanded(
                flex: 2,
                child: _summonerSearch(),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 80,
                  margin: EdgeInsets.only(top: 30),
                  child: _mostSearchedPlayers(),
                ),
              ),
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
            horizontal: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                ? 40
                : 25,
          ),
          child: _inputForSummonerName(),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                ? 40
                : 25,
          ),
          child: _buttonForSearchSummoner(),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                ? 40
                : 25,
          ),
          child: RegionDropDownComponent(
            initialRegion: initialRegion,
            onRegionChoose: (region) {
              setState(() {
                _currentGameController.setAndSaveActualRegion(region);
              });
            },
          ),
        ),
      ],
    );
  }

  _screenInformation() {
    return Container(
      margin: EdgeInsets.only(top: 80, left: 30, right: 30),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: -1,
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Text(
                AppLocalizations.of(context)!.titleHomePage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text(
              AppLocalizations.of(context)!.titleHomePage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration _currentGameBackgroundImage() {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      image: DecorationImage(
        image: AssetImage(imageBackgroundCurrentGame),
        fit: BoxFit.cover,
      ),
    );
  }

  _inputForSummonerName() {
    return Form(
      key: currentGameUserFormKey,
      child: Obx(() {
        return TextFormField(
          enabled: !_currentGameController.isLoadingUser.value,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.hintSummonerName,
            hintStyle: TextStyle(
              fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                  ? 16
                  : 12,
            ),
            errorStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.black,
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
      margin: const EdgeInsets.symmetric(vertical: 30),
      height: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 54 : 45,
      child: Obx(() {
        return OutlinedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _whichMessageShowToUser(),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize:
                      _masterController.screenWidthSizeIsBiggerThanNexusOne()
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

  _mostSearchedPlayers() {
    return Obx(
      () => _masterController.favoriteUsers.length > 0
          ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _masterController.favoriteUsers.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _favoritePlayerCard(context, index);
              },
            )
          : _favoriteUserBoardInformation(),
    );
  }

  _favoritePlayerCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        _currentGameController.userNameInputController.text =
            _masterController.favoriteUsers[index].name;
      },
      child: Container(
        width: 180,
        margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    width: 80,
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      _masterController.favoriteUsers[index].name,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    child: _masterController
                            .favoriteUsers[index].userTier.isNotEmpty
                        ? Image.network(
                            _masterController.getUserTierImage(
                              _masterController.favoriteUsers[index].userTier,
                            ),
                            width: 17,
                          )
                        : Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Image.asset(
                              imageUnranked,
                              width: 17,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _masterController.removeFavoriteUser(index);
              },
              child: Container(
                height: 50,
                width: 43,
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _favoriteUserBoardInformation() {
    return Container(
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.favoriteUsers),
          Container(
            //margin: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            color: Theme.of(context).backgroundColor.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

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
      _currentGameController.processCurrentGame();
    }
  }
}

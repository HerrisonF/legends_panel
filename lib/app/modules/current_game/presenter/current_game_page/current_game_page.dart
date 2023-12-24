import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/widgets/header_screen_information.dart';
import 'package:legends_panel/app/core/widgets/region_dropdown_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_controller.dart';

class CurrentGamePage extends StatefulWidget {
  @override
  State<CurrentGamePage> createState() => _CurrentGamePageState();
}

class _CurrentGamePageState extends State<CurrentGamePage> {
  final GlobalKey<FormState> currentGameUserFormKey = GlobalKey<FormState>();

  final CurrentGameController _currentGameController =
      GetIt.I<CurrentGameController>();

  String initialRegion = 'NA';

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
                bottomSpace: 30,
              ),
              _summonerSearch(),
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
            horizontal: 25,
          ),
          child: _inputForSummonerName(),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: _buttonForSearchSummoner(),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: ValueListenableBuilder(
            valueListenable: _currentGameController.isLoadingUser,
            builder: (context, value, _) {
              return RegionDropDownComponent(
                initialRegion: initialRegion,
                onRegionChoose: (region) {
                  setState(
                    () {},
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
                  fontSize: 12,
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
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 45,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (_currentGameController.isLoadingUser.value) CircularProgressIndicator()
              ],
            ),
            onPressed: _currentGameController.isShowingMessage.value
                ? null
                : () {
                    _validateAndSearchSummoner();
                  },
          );
        },
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
      FocusScope.of(context).unfocus();
      _currentGameController.processCurrentGame(context);
    }
  }
}

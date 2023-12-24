import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/widgets/region_dropdown_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_controller.dart';

class CurrentGamePage extends StatefulWidget {
  @override
  State<CurrentGamePage> createState() => _CurrentGamePageState();
}

class _CurrentGamePageState extends State<CurrentGamePage> {
  final GlobalKey<FormState> currentGameUserFormKey = GlobalKey<FormState>();
  final TextEditingController userNameInputController = TextEditingController();

  final CurrentGameController _currentGameController =
      GetIt.I<CurrentGameController>();

  String initialRegion = 'NA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageBackgroundCurrentGame),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor.withOpacity(0.7),
              BlendMode.plus,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!
                      .titleCurrentGamePage
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: _summonerSearch(),
            ),
          ],
        ),
      ),
    );
  }

  _summonerSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: _inputForSummonerName(),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: _buttonSearchSummoner(),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: ValueListenableBuilder(
                    valueListenable: _currentGameController.isLoadingUser,
                    builder: (context, isLoading, _) {
                      return RegionDropDownComponent(
                        initialRegion: initialRegion,
                        onRegionChoose: (region) {
                          setState(() {
                            print(region);
                          });
                        },
                        isLoading: isLoading,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
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
                color: Colors.white,
              ),
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow),
              ),
              border: const OutlineInputBorder(),
              errorStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            controller: userNameInputController,
            validator: (value) {
              if (value!.trim().isEmpty) {
                userNameInputController.clear();
                return AppLocalizations.of(context)!.inputValidatorHome;
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Container _buttonSearchSummoner() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFF2E4053),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ValueListenableBuilder(
        valueListenable: _currentGameController.isLoadingUser,
        builder: (context, isLoading, _) {
          return isLoading
              ? Center(child: CircularProgressIndicator())
              : OutlinedButton(
                  child: Text(
                    _whichMessageShowToUser(),
                    style: GoogleFonts.montserrat(
                      color: Colors.yellow,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (!isLoading) {
                      _validateAndSearchSummoner();
                    }
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

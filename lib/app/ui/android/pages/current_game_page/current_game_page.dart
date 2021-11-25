import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/current_game_controller/current_game_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/ui/android/components/region_dropdown_component.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentGamePage extends StatefulWidget {
  @override
  State<CurrentGamePage> createState() => _CurrentGamePageState();
}

class _CurrentGamePageState extends State<CurrentGamePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CurrentGameController _currentGameController =
      Get.put(CurrentGameController());

  String selectedRegion = 'NA1';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: _blueAndImageBackground(context),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _inputSummonerNameForSearchCurrentGame(),
              _buttonSearchForSummoner(context),
              RegionDropDownComponent(onRegionChoose: (region) {
                setState(() {
                  this.selectedRegion = region;
                });
              }),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration _blueAndImageBackground(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      image: DecorationImage(
        image: AssetImage(imageBackgroundCurrentGame),
        fit: BoxFit.cover,
      ),
    );
  }

  Container _inputSummonerNameForSearchCurrentGame() {
    return Container(
      child: Form(
        key: formKey,
        child: Obx(() {
          return TextFormField(
            enabled: !_currentGameController.isLoadingUser.value,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.hintSummonerName,
              errorStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, color: Colors.white),
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
      ),
    );
  }

  Container _buttonSearchForSummoner(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      height: 50,
      child: Obx(() {
        return OutlinedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentGameController.isLoadingUser.value
                    ? AppLocalizations.of(context)!.searching
                    : _currentGameController.isShowingMessage.value
                        ? AppLocalizations.of(context)!
                            .buttonMessageUserNotFound
                        : _currentGameController
                                .isShowingMessageUserIsNotPlaying.value
                            ? AppLocalizations.of(context)!
                                .buttonMessageGameNotFound
                            : AppLocalizations.of(context)!.buttonMessageSearch,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _currentGameController.isLoadingUser.value
                  ? JumpingDotsProgressIndicator(
                      fontSize: 22,
                      color: Colors.white,
                    )
                  : SizedBox.shrink()
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

  _validateAndSearchSummoner() {
    if (formKey.currentState!.validate()) {
      UtilController.closeKeyBoard(context);
      _currentGameController.getUserFromCloud(selectedRegion);
    }
  }
}

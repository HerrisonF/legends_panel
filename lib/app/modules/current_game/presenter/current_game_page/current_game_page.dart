import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/current_game_repository_impl.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/fetch_puuid_and_summonerID_from_riot_usecase_impl.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_controller.dart';

class CurrentGamePage extends StatefulWidget {
  @override
  State<CurrentGamePage> createState() => _CurrentGamePageState();
}

class _CurrentGamePageState extends State<CurrentGamePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController summonerNameInputController;
  late TextEditingController tagLineInputController;

  late CurrentGameController _currentGameController;

  @override
  void initState() {
    summonerNameInputController = TextEditingController();
    tagLineInputController = TextEditingController();
    _currentGameController = CurrentGameController(
      fetchPUUIDAndSummonerIDFromRiotUsecase:
          FetchPUUIDAndSummonerIDFromRiotUsecaseImpl(
        currentGameRepository: CurrentGameRepositoryImpl(
          logger: GetIt.I<Logger>(),
          httpServices: GetIt.I<HttpServices>(),
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    summonerNameInputController.dispose();
    tagLineInputController.dispose();
    super.dispose();
  }

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
          Container(
            margin: EdgeInsets.only(top: 20),
            child: _buttonSearchSummoner(),
          ),
        ],
      ),
    );
  }

  _inputForSummonerName() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              enabled: !_currentGameController.isLoadingUser.value,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.hintSummonerName,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                enabledBorder: const OutlineInputBorder(
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
              controller: summonerNameInputController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  summonerNameInputController.clear();
                  return AppLocalizations.of(context)!.inputValidatorHome;
                }
                return null;
              },
            ),
          ),
          TextFormField(
            enabled: !_currentGameController.isLoadingUser.value,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.hintTagline,
              hintStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
              enabledBorder: const OutlineInputBorder(
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
            controller: tagLineInputController,
            validator: (value) {
              if (value!.trim().isEmpty) {
                tagLineInputController.clear();
                return AppLocalizations.of(context)!.inputValidatorHome;
              }
              return null;
            },
          )
        ],
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
                    _messageToShowToUser(),
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

  String _messageToShowToUser() {
    if (_currentGameController.isLoadingUser.value) {
      return AppLocalizations.of(context)!.searching;
    }
    if (_currentGameController.isShowingMessage.value) {
      return AppLocalizations.of(context)!.buttonMessageUserNotFound;
    }
    if (_currentGameController.isShowingMessageUserIsNotPlaying.value) {
      return AppLocalizations.of(context)!.buttonMessageGameNotFound;
    }

    return AppLocalizations.of(context)!.buttonMessageSearch;
  }

  _validateAndSearchSummoner() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _currentGameController.searchGoingOnGame(
        summonerName: summonerNameInputController.text,
        tag: tagLineInputController.text,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/current_game_repository_impl.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/active_games/fetch_active_game_by_summoner_id_usecase_impl.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_puuid_and_summonerID_from_riot_usecase_impl.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_summoner_profile_by_puuid_usecase_impl.dart';
import 'package:legends_panel/app/modules/current_game/presenter/active_game/active_game_search_controller.dart';

class ActiveGameSearchPage extends StatefulWidget {
  @override
  State<ActiveGameSearchPage> createState() => _ActiveGameSearchPageState();
}

class _ActiveGameSearchPageState extends State<ActiveGameSearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController summonerNameInputController;
  late TextEditingController tagLineInputController;

  late ActiveGameSearchController _activeGameSearchController;

  @override
  void initState() {
    summonerNameInputController = TextEditingController();
    tagLineInputController = TextEditingController();
    final _repository = CurrentGameRepositoryImpl(
      logger: GetIt.I<Logger>(),
      httpServices: GetIt.I<HttpServices>(),
    );
    _activeGameSearchController = ActiveGameSearchController(
      fetchPUUIDAndSummonerIDFromRiotUsecase:
          FetchPUUIDAndSummonerIDFromRiotUsecaseImpl(
        currentGameRepository: _repository,
      ),
      fetchActiveGameBySummonerIDUsecase:
          FetchActiveGameBySummonerIDUsecaseImpl(
        currentGameRepository: _repository,
      ),
      fetchSummonerProfileByPUUIDUsecase:
          FetchSummonerProfileByPUUIDUsecaseImpl(
        currentGameRepository: _repository,
      ),
      generalController: GetIt.I<GeneralController>(),
      goToGameResultPageCallback: goToActiveGamePageResult,
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
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buttonSearchSummoner(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          AppLocalizations.of(context)!.region,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xFF2E4053),
                        ),
                        child: DropdownButton<String>(
                          underline: SizedBox.shrink(),
                          itemHeight: 50,
                          value:
                              _activeGameSearchController.selectedRegion.value,
                          items: _activeGameSearchController.regions
                              .map((String region) {
                            return DropdownMenuItem<String>(
                              value: region,
                              alignment: Alignment.center,
                              child: Text(
                                region,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                              ),
                            );
                          }).toList(),
                          elevation: 0,
                          isExpanded: true,
                          dropdownColor: Color(0xFF2E4053),
                          menuMaxHeight: 150,
                          onChanged: (String? newValue) {
                            setState(() {
                              _activeGameSearchController.selectedRegion.value =
                                  newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _inputForSummonerName() {
    return Form(
      key: _formKey,
      child: ValueListenableBuilder(
        valueListenable: _activeGameSearchController.isLoadingUser,
        builder: (context, isLoading, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  enabled: !_activeGameSearchController.isLoadingUser.value,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.hintSummonerName,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
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
                enabled: !_activeGameSearchController.isLoadingUser.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: AppLocalizations.of(context)!.hintTagline,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
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
      margin: EdgeInsets.only(top: 22),
      child: ValueListenableBuilder(
        valueListenable: _activeGameSearchController.isLoadingUser,
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
    if (_activeGameSearchController.isShowingMessageUserIsNotPlaying.value) {
      return AppLocalizations.of(context)!.buttonMessageGameNotFound;
    }
    if (_activeGameSearchController.isLoadingUser.value) {
      return AppLocalizations.of(context)!.searching;
    }

    return AppLocalizations.of(context)!.buttonMessageSearch;
  }

  _validateAndSearchSummoner() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _activeGameSearchController.searchActiveGame(
        summonerName: summonerNameInputController.text,
        tag: tagLineInputController.text,
      );
    }
  }

  goToActiveGamePageResult(ActiveGameInfoModel activeGameInfoModel) {
    context.push(
      RoutesPath.ACTIVE_GAME_RESULT,
      extra: activeGameInfoModel,
    );
  }
}

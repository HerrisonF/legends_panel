import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/constants/regions_constants.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_search_repository_impl.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_puuid_and_summonerID_from_riot_usecase_impl.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_summoner_profile_by_puuid_usecase_impl.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_controller/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ProfileController _profileController;
  late TextEditingController summonerNameInputController;
  late TextEditingController tagLineInputController;

  @override
  void initState() {
    ProfileRepository _profileRepository = ProfileRepository(
      logger: GetIt.I<Logger>(),
      httpServices: GetIt.I<HttpServices>(),
    );
    final _repositoryActiveGame = ActiveGameSearchRepositoryImpl(
      logger: GetIt.I<Logger>(),
      httpServices: GetIt.I<HttpServices>(),
    );
    summonerNameInputController = TextEditingController();
    tagLineInputController = TextEditingController();
    _profileController = ProfileController(
      fetchSummonerProfileByPUUIDUsecase:
          FetchSummonerProfileByPUUIDUsecaseImpl(
        activeGameSearchRepository: _repositoryActiveGame,
      ),
      fetchPUUIDAndSummonerIDFromRiotUsecase:
          FetchPUUIDAndSummonerIDFromRiotUsecaseImpl(
        activeGameSearchRepository: _repositoryActiveGame,
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.5),
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              child: Image.asset(
                imageBackgroundProfilePengu,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.titleProfilePage,
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
                flex: 2,
                child: _summonerSearch(),
              ),
            ],
          ),
        ],
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
                          value: _profileController.selectedRegion.value,
                          items: RegionsConstants.regions.map((String region) {
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
                              _profileController.selectedRegion.value =
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
        valueListenable: _profileController.isLoadingProfile,
        builder: (context, isLoading, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  enabled: !_profileController.isLoadingProfile.value,
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
                enabled: !_profileController.isLoadingProfile.value,
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
        valueListenable: _profileController.isLoadingProfile,
        builder: (context, isLoading, _) {
          return isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
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
    if (_profileController.isShowingMessageUserNotExist.value) {
      return AppLocalizations.of(context)!.buttonMessageUserNotFound;
    }
    if (_profileController.isLoadingProfile.value) {
      return AppLocalizations.of(context)!.searching;
    }

    return AppLocalizations.of(context)!.buttonMessageSearch.toUpperCase();
  }

  _validateAndSearchSummoner() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _profileController.searchProfile(
        summonerName: summonerNameInputController.text,
        tag: tagLineInputController.text,
      );
    }
  }

  goToProfilePageResult() {
    context.push(
      RoutesPath.PROFILE_RESULT,
    );
  }
}

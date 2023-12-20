import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/widgets/header_screen_information.dart';
import 'package:legends_panel/app/core/widgets/region_dropdown_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_controller/profile_controller.dart';

class SearchUserProfileComponent extends StatefulWidget {
  const SearchUserProfileComponent({Key? key}) : super(key: key);

  @override
  State<SearchUserProfileComponent> createState() =>
      _SearchUserProfileComponentState();
}

class _SearchUserProfileComponentState
    extends State<SearchUserProfileComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ProfileController _profileController = GetIt.I<ProfileController>();

  String initialRegion = '';

  @override
  void initState() {
    getLastStoredRegionForProfile();
    super.initState();
  }

  getLastStoredRegionForProfile() {
    String receivedRegion = _profileController.getLastStoredRegionForProfile();
    initialRegion = receivedRegion.isEmpty ? 'NA' : receivedRegion;
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
          Container(
            child: ListView(
              children: [
                HeaderScreenInformation(
                  title: AppLocalizations.of(context)!.titleProfilePage,
                  topSpace: 40,
                  bottomSpace: 85,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: _inputSummonerName(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: _buttonSearchSummoner(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ValueListenableBuilder(
                      valueListenable: _profileController.isUserLoading,
                      builder: (context, value, _) {
                        return RegionDropDownComponent(
                          initialRegion: initialRegion,
                          onRegionChoose: (region) {
                            setState(() {
                              _profileController.saveActualRegion(region);
                            });
                          },
                          isLoading: _profileController.isUserLoading.value,
                        );
                      }),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   height: 50,
                //   margin: EdgeInsets.only(
                //       top: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                //           ? 65
                //           : 20,
                //       bottom: 90),
                //   child: _mostSearchedPlayers(),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buttonSearchSummoner() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 55,
      child: ValueListenableBuilder(
          valueListenable: _profileController.isUserLoading,
          builder: (context, value, _) {
            return OutlinedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    whichMessageShowToUser(),
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (_profileController.isUserLoading.value) CircularProgressIndicator()
                ],
              ),
              onPressed: _profileController.isShowingMessage.value
                  ? null
                  : () {
                      _searchForUserOnCloud();
                    },
            );
          }),
    );
  }

  String whichMessageShowToUser() {
    return _profileController.isUserFound.value
        ? AppLocalizations.of(context)!.userFound
        : _profileController.isUserLoading.value
            ? AppLocalizations.of(context)!.searching
            : _profileController.isShowingMessage.value
                ? AppLocalizations.of(context)!.buttonMessageUserNotFound
                : _profileController.isShowingMessageUserIsNotPlaying.value
                    ? AppLocalizations.of(context)!.buttonMessageGameNotFound
                    : AppLocalizations.of(context)!.buttonMessageSearch;
  }

  _inputSummonerName() {
    return Form(
      key: formKey,
      child: ValueListenableBuilder(
        valueListenable: _profileController.isUserLoading,
        builder: (context, value, _) {
          return TextFormField(
            enabled: !_profileController.isUserLoading.value,
            controller: _profileController.userNameInputController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.hintSummonerName,
              hintStyle: TextStyle(
                fontSize: 12,
              ),
              errorStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                _profileController.userNameInputController.clear();
                return AppLocalizations.of(context)!.inputValidatorHome;
              }
              if (initialRegion.isEmpty) {
                _profileController.userNameInputController.clear();
                return AppLocalizations.of(context)!.inputValidatorHome;
              }
              return null;
            },
          );
        },
      ),
    );
  }

  _searchForUserOnCloud() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _profileController
          .getUser(_profileController.getLastStoredRegionForProfile());
    }
  }
}

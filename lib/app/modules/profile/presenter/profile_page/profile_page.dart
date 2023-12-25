import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_controller/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final  formKey = GlobalKey<FormState>();
  late ProfileController _profileController;
  TextEditingController userNameInputController = TextEditingController();

  String initialRegion = 'NA';

  @override
  void initState() {
    _profileController = ProfileController(
      profileRepository: ProfileRepository(
        logger: GetIt.I<Logger>(),
        httpServices: GetIt.I<HttpServices>(),
      ),
    );
    super.initState();
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
                Text(
                  AppLocalizations.of(context)!.titleProfilePage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 40),
                //   child: _inputSummonerName(),
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: _buttonSearchSummonerProfile(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buttonSearchSummonerProfile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 55,
      child: ValueListenableBuilder(
          valueListenable: _profileController.isLoadingProfile,
          builder: (context, isLoading, _) {
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
                  if (isLoading) CircularProgressIndicator()
                ],
              ),
              onPressed: () {
                _searchForUserOnCloud();
              },
            );
          }),
    );
  }

  String whichMessageShowToUser() {
    return _profileController.isProfileFound.value
        ? AppLocalizations.of(context)!.userFound
        : _profileController.isLoadingProfile.value
            ? AppLocalizations.of(context)!.searching
            : _profileController.isShowingMessage.value
                ? AppLocalizations.of(context)!.buttonMessageUserNotFound
                : _profileController.isShowingMessageUserIsNotPlaying.value
                    ? AppLocalizations.of(context)!.buttonMessageGameNotFound
                    : AppLocalizations.of(context)!.buttonMessageSearch;
  }

  // _inputSummonerName() {
  //   return Form(
  //     key: formKey,
  //     child: ValueListenableBuilder(
  //       valueListenable: _profileController.isLoadingProfile,
  //       builder: (context, value, _) {
  //         return TextFormField(
  //           enabled: !_profileController.isLoadingProfile.value,
  //           controller: userNameInputController,
  //           decoration: InputDecoration(
  //             hintText: AppLocalizations.of(context)!.hintSummonerName,
  //             hintStyle: TextStyle(
  //               fontSize: 12,
  //             ),
  //             errorStyle: TextStyle(
  //               fontWeight: FontWeight.w500,
  //               color: Colors.black,
  //             ),
  //           ),
  //           validator: (value) {
  //             if (value!.trim().isEmpty) {
  //               userNameInputController.clear();
  //               return AppLocalizations.of(context)!.inputValidatorHome;
  //             }
  //             userNameInputController.clear();
  //             return AppLocalizations.of(context)!.inputValidatorHome;
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  _searchForUserOnCloud() {
    // if (formKey.currentState!.validate()) {
    //   FocusScope.of(context).unfocus();
    // }
  }
}

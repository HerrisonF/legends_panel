import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';
import 'package:legends_panel/app/ui/android/components/region_dropdown_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchUserProfileComponent extends StatefulWidget {
  const SearchUserProfileComponent({Key? key}) : super(key: key);

  @override
  State<SearchUserProfileComponent> createState() =>
      _SearchUserProfileComponentState();
}

class _SearchUserProfileComponentState
    extends State<SearchUserProfileComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ProfileController _profileController = Get.find<ProfileController>();
  final MasterController _masterController = Get.find<MasterController>();

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
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.5),
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
        image: DecorationImage(
          image: AssetImage(imageBackgroundProfilePengu),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _inputSummonerName(),
          _buttonSearchSummoner(),
          RegionDropDownComponent(
            initialRegion: initialRegion,
            onRegionChoose: (region) {
              setState(() {
                _profileController.saveActualRegion(region);
              });
            },
          ),
        ],
      ),
    );
  }

  Container _buttonSearchSummoner() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      height: 50,
      child: Obx(() {
        return OutlinedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                whichMessageShowToUser(),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 15 : 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (_profileController.isUserLoading.value) DotsLoading()
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
      child: Obx(() {
        return TextFormField(
          enabled: !_profileController.isUserLoading.value,
          controller: _profileController.userNameInputController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.hintSummonerName,
            hintStyle: TextStyle(
              fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 16 : 12,
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
      }),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/core/utils/screen_utils.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';
import 'package:legends_panel/app/ui/android/components/header_screen_information.dart';
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
                  bottomSpace: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                      ? 86
                      : 40,
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
                  child: Obx(() {
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
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  margin: EdgeInsets.only(
                      top: ScreenUtils
                              .screenWidthSizeIsBiggerThanNexusOne()
                          ? 65
                          : 20,
                      bottom: 90),
                  child: _mostSearchedPlayers(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _mostSearchedPlayers() {
    return Obx(
      () => _masterController.favoriteUsersForProfile.length > 0
          ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _masterController.favoriteUsersForProfile.length,
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
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _profileController.isUserLoading.value
                  ? null
                  : () {
                      _profileController.userNameInputController.text =
                          _masterController.favoriteUsersForProfile[index].name;
                    },
              child: Container(
                height: 60,
                color: Theme.of(context).backgroundColor,
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      child: Text(
                        _masterController.favoriteUsersForProfile[index].name,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      child: _masterController.favoriteUsersForProfile[index]
                              .userTier.isNotEmpty
                          ? Image.asset(
                              _masterController.getUserTierImage(
                                _masterController
                                    .favoriteUsersForProfile[index].userTier,
                              ),
                              width: 17,
                            )
                          : Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Image.asset(
                                imageUnranked,
                                width: 17,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _masterController.removeFavoriteUserForProfile(index);
              },
              child: Container(
                height: 60,
                width: 43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Colors.white,
                ),
                child: Container(
                  child: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  _favoriteUserBoardInformation() {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 50,
            color: Theme.of(context).backgroundColor.withOpacity(0.2),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              AppLocalizations.of(context)!.favoriteUsers,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buttonSearchSummoner() {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
              ? 45
              : 20),
      height: 55,
      child: Obx(() {
        return OutlinedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                whichMessageShowToUser(),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize:
                  ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                          ? 15
                          : 12,
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
              fontSize: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                  ? 16
                  : 12,
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

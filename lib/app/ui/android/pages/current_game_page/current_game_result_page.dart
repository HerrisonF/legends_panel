import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_result_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/ui/android/pages/current_game_page/current_game_participant_card.dart';

class CurrentGameResultPage extends StatelessWidget {
  final CurrentGameResultController _currentGameResultController =
      Get.find<CurrentGameResultController>();
  final MasterController _masterController = Get.find<MasterController>();

  static const int NEXUS_ONE_SCREEN = 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => this._backToHome(context),
        child: Stack(
          children: [
            _backgroundFullImage(),
            _mapImage(context),
            _listUser(context)
          ],
        ),
      ),
    );
  }

  _backToHome(context) {
    Navigator.pop(context);
  }

  Widget _listUser(context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _mapName(context),
              _gameClock(context),
              _userName(context),
              _detachTeams(context),
            ],
          ),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN
                    ? 22
                    : 16,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Row _mapName(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() {
          return Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN
                    ? 90
                    : 80),
            child: Text(
              _currentGameResultController.mapMode.value.mapName == ""
                  ? "LOADING_MESSAGE".tr
                  : _currentGameResultController.mapMode.value.mapName,
              style: GoogleFonts.adamina(
                fontSize: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? 16: 12,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          );
        }),
      ],
    );
  }

  Container _gameClock(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              imageIconClock,
              height: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? 20: 16,
            ),
            margin: EdgeInsets.only(right: 10),
          ),
          Text(
            "${_currentGameResultController.getCurrentGameMinutes()} Min",
            style: GoogleFonts.aBeeZee(
              fontSize: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? 16: 12,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Container _userName(BuildContext context) {
    return Container(
      child: Text(_masterController.userCurrentGame.value.name,
          style: GoogleFonts.aBeeZee(
            fontSize: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? 16: 14,
            color: Colors.white,
            letterSpacing: 0.5,
          )),
    );
  }

  ShaderMask _mapImage(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageMapSelect),
            fit: BoxFit.cover,
          ),
        ),
        //color: Colors.amber,
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Container _backgroundFullImage() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imageBackgroundProfilePage), fit: BoxFit.cover),
      ),
    );
  }

  _detachTeams(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height > 800 ? 24 : 6.5,
              left: 10,
              right: 0,
              child: Container(
                child: Image.asset(imageDivider, height: MediaQuery.of(context).size.height > 800 ? 40 : 30),
              ),
            ),
            Obx(() {
              return _teamCard(_currentGameResultController.blueTeam,
                  _currentGameResultController.blueTeamBannedChamp);
            }),
          ],
        ),
        Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height > 800 ? 24 : 6.5,
              left: 10,
              right: 0,
              child: Container(
                child: Image.asset(imageDivider, height: MediaQuery.of(context).size.height > 800 ? 40 : 30),
              ),
            ),
            Obx(() {
              return _teamCard(_currentGameResultController.redTeam,
                  _currentGameResultController.redTeamBannedChamp);
            }),
          ],
        ),
      ],
    );
  }

  _teamCard(RxList<CurrentGameParticipant> participants,
      RxList<CurrentGameBannedChampion> bannedChampions) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: participants.length,
      itemBuilder: (_, index) {
        return CurrentGameParticipantCard(participants[index],
            bannedChampions[index], _currentGameResultController.region);
      },
    );
  }
}

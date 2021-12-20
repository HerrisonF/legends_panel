import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_result_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/ui/android/components/timer_text.dart';
import 'package:legends_panel/app/ui/android/pages/current_game_page/current_game_participant_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentGameResultPage extends StatelessWidget {
  final CurrentGameResultController _currentGameResultController =
      Get.find<CurrentGameResultController>();

  final MasterController _masterController = Get.find<MasterController>();

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
            margin: EdgeInsets.only(left: 15, top: 20),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: _masterController.screenWidthSizeIsBiggerThanNexusOne()
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

  _mapName(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                    ? 100
                    : 80),
            child: Text(
              _currentGameResultController.currentMapToShow.value.map.isEmpty
                  ? AppLocalizations.of(context)!.loadingMessage
                  : _currentGameResultController.currentMapToShow.value.map,
              style: GoogleFonts.aBeeZee(
                  fontSize:_masterController.screenWidthSizeIsBiggerThanNexusOne()
                      ? 18
                      : 12,
                  color: Colors.white,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            child: Text(
                _currentGameResultController.currentMapToShow.value.description,
              style: GoogleFonts.aBeeZee(
                  fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                      ? 14
                      : 8,
                  color: Colors.white,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      );
    });
  }

  Container _gameClock(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.access_alarm_outlined,
              size: 16,
              color: Colors.white,
            ),
            margin: EdgeInsets.only(right: 5),
          ),
          TimerText(time: _currentGameResultController.getCurrentGameMinutes()),
        ],
      ),
    );
  }

  Container _userName(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        _masterController.userForCurrentGame.value.name,
        style: GoogleFonts.aBeeZee(
            fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                ? 16
                : 14,
            color: Colors.white,
            letterSpacing: 0.2,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  ShaderMask _mapImage(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(
          Rect.fromLTRB(0, 0, rect.width, rect.height),
        );
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
      ),
    );
  }

  Container _backgroundFullImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageBackgroundProfilePage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _detachTeams(BuildContext context) {
    return Column(
      children: [
        _teamCard(_currentGameResultController.blueTeam, context),
        _teamCard(_currentGameResultController.redTeam, context),
      ],
    );
  }

  _teamCard(RxList<CurrentGameParticipant> participants, context) {
    return Container(
      height: _masterController.screenWidthSizeIsBiggerThanNexusOne()
          ? 355
          : 290,
      margin: EdgeInsets.only(
        bottom: _masterController.screenWidthSizeIsBiggerThanNexusOne()
            ? 0
            : 5,
        top: _masterController.screenWidthSizeIsBiggerThanNexusOne()
            ? 0
            : 10,
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: participants.length,
        itemBuilder: (_, index) {
          return CurrentGameParticipantCard(
            participant: participants[index],
            region: _currentGameResultController.region,
          );
        },
      ),
    );
  }
}

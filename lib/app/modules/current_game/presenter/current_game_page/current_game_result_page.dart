import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/widgets/timer_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/queues_controller.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_result_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_participant_card.dart';

class CurrentGameResultPage extends StatelessWidget {
  final CurrentGameResultController _currentGameResultController =
      GetIt.I<CurrentGameResultController>();
  final QueuesController _queuesController = GetIt.I.get<QueuesController>();

  final MasterController _masterController = GetIt.I<MasterController>();

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
    _masterController.resetCurrentGameUser();
  }

  Widget _listUser(context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _mapName(context),
              _gameClockAndTimerText(),
              _userName(),
              _detachTeams(),
            ],
          ),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 10, top: 20),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 16,
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
    return ValueListenableBuilder(
        valueListenable: _queuesController.currentMapToShow,
        builder: (context, value, _) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Text(
                  _queuesController.currentMapToShow.value.map.isEmpty
                      ? AppLocalizations.of(context)!.loadingMessage
                      : _queuesController.currentMapToShow.value.map,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 12,
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                child: Text(
                  _currentGameResultController.getCurrentMapDescription(),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 8,
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Container _gameClockAndTimerText() {
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

  Container _userName() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: Text(
        _masterController.userForCurrentGame.name,
        style: GoogleFonts.aBeeZee(
          fontSize: 14,
          color: Colors.white,
          letterSpacing: 0.2,
          fontWeight: FontWeight.bold,
        ),
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

  _detachTeams() {
    return Column(
      children: [
        _teamCard(_currentGameResultController.blueTeam.value, 100),
        _teamCard(_currentGameResultController.redTeam.value, 200),
      ],
    );
  }

  _teamCard(List<CurrentGameParticipant> participants, int team) {
    return Container(
      margin: EdgeInsets.only(
        top: team == 200 ? 20 : 0,
        bottom: team == 200 ? 20 : 0,
      ),
      height: 318,
      child: ListView.builder(
        padding: EdgeInsets.zero,
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

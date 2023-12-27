import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/widgets/timer_text.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/presenter/active_game/active_game_result_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/active_game/current_game_participant_card.dart';

class ActiveGameResultPage extends StatefulWidget {
  late final ActiveGameInfoModel activeGameInfoModel;

  ActiveGameResultPage({
    required this.activeGameInfoModel,
  });

  @override
  State<ActiveGameResultPage> createState() => _ActiveGameResultPageState();
}

class _ActiveGameResultPageState extends State<ActiveGameResultPage> {
  late ActiveGameResultController controller;

  @override
  void initState() {
    controller = ActiveGameResultController(
      activeGameInfoModel: widget.activeGameInfoModel,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageBackgroundProfilePage),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 10, top: 20),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  onPressed: () {
                    context.pop(context);
                  },
                  color: Colors.white,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller.isLoading,
              builder: (_, isLoading, __) {
                return isLoading ? _shimmerLoading() : _gameInfoContent();
              },
            ),
          ],
        ),
      ),
    );
  }

  _gameInfoContent() {
    return Expanded(
      child: ListView(
        children: [
          _gameClockAndTimerText(),
          _userName(),
          _teams(),
        ],
      ),
    );
  }

  Container _gameClockAndTimerText() {
    return Container(
      margin: EdgeInsets.only(top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.access_alarm_outlined,
              size: 20,
              color: Colors.white,
            ),
            margin: EdgeInsets.only(right: 5),
          ),
          TimerText(
            time: controller.getCurrentGameMinutes(),
          ),
        ],
      ),
    );
  }

  Container _userName() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 50,
        bottom: 20,
      ),
      child: Text(
        controller.activeGameInfoModel.summonerProfileModel!.name,
        style: GoogleFonts.aBeeZee(
          fontSize: 14,
          color: Colors.yellow,
          letterSpacing: 0.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _teams() {
    return Column(
      children: [
        _teamCard(controller.blueTeam, 100),
        _bannerChampionsBlueTeam(),
        _teamCard(controller.redTeam, 200),
        _bannedChampionsRedTeam(),
      ],
    );
  }

  _teamCard(
    List<ActiveGameParticipantModel> participants,
    int team,
  ) {
    return Container(
      margin: EdgeInsets.only(
        top: team == 200 ? 20 : 0,
        bottom: team == 200 ? 20 : 0,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: participants
            .map(
              (e) => CurrentGameParticipantCard(
                participant: e,
                region: '',
                isToPaintUserName: e.summonerName ==
                    controller.activeGameInfoModel.summonerProfileModel!.name,
              ),
            )
            .toList(),
      ),
    );
  }

  _bannedChampionsRedTeam() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: controller.bansReadTeam
          .map(
            (e) => Container(
              color: Colors.redAccent,
              child: Text(e.championId.toString()),
            ),
          )
          .toList(),
    );
  }

  _bannerChampionsBlueTeam() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: controller.bansBlueTeam
          .map(
            (e) => Container(
              color: Colors.blue,
              child: Text(e.championId.toString()),
            ),
          )
          .toList(),
    );
  }

  _shimmerLoading() {
    return CircularProgressIndicator();
  }
}

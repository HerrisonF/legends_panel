import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/core/widgets/timer_text.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/presenter/active_game/active_game_result/components/active_game_participant_card.dart';

import 'active_game_result_controller.dart';

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
      generalController: GetIt.I<GeneralController>(),
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
            Row(
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
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.access_alarm_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 45),
                          child: TimerText(
                            time: controller.getCurrentGameMinutes(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
          _userName(),
          _teams(),
        ],
      ),
    );
  }

  Container _userName() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Summoner",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            controller.activeGameInfoModel.summonerProfileModel!
                .summonerIdentificationModel!.gameName,
            style: GoogleFonts.aBeeZee(
              fontSize: 14,
              color: Colors.yellow,
              letterSpacing: 0.2,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  _teams() {
    return Column(
      children: [
        _teamCard(controller.blueTeam, 100),
        _banText(),
        Container(
          margin: EdgeInsets.only(top: 2),
          height: 40,
          child: _bannerChampionsBlueTeam(),
        ),
        _teamCard(controller.redTeam, 200),
        _banText(),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 20),
          height: 40,
          child: _bannedChampionsRedTeam(),
        ),
      ],
    );
  }

  _banText() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      alignment: Alignment.center,
      child: Text(
        "BAN",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _teamCard(
    List<ActiveGameParticipantModel> participants,
    int team,
  ) {
    return Container(
      margin: EdgeInsets.only(
        top: team == 200 ? 20 : 0,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: participants
            .map(
              (e) => ActiveGameParticipantCard(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: controller.bansReadTeam
          .map((e) => _championBadge(e.championId))
          .toList(),
    );
  }

  _bannerChampionsBlueTeam() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: controller.bansBlueTeam
          .map(
            (e) => _championBadge(e.championId),
          )
          .toList(),
    );
  }

  Widget _championBadge(int id) {
    return Container(
      child: id > 0
          ? Image.network(
              controller.generalController.getChampionBadgeUrl(id),
            )
          : Image.asset(imageNoChampion),
    );
  }

  _shimmerLoading() {
    return CircularProgressIndicator();
  }
}

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
                          child: Text(
                            "${controller.generalController.lolConstantsModel.getMapNameById(
                              mapId: controller.activeGameInfoModel.mapId,
                            )} - ",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 14,
                              color: Colors.white,
                            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _userName(),
              _gameQueueName(),
            ],
          ),
          _teams(),
        ],
      ),
    );
  }

  Container _gameQueueName() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Text(
        controller.generalController.lolConstantsModel.getQueueNameById(
          queueId: controller.activeGameInfoModel.gameQueueConfigId,
        ),
        style: GoogleFonts.aBeeZee(
          fontSize: 14,
          color: Colors.white,
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.activeGameInfoModel.summonerProfileModel!
                .summonerIdentificationModel!.gameName,
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              "is playing",
              style: TextStyle(color: Colors.white),
            ),
          ),
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
      margin: EdgeInsets.only(top: 10),
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

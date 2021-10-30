import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_result_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/ui/android/pages/current_game_page/current_game_participant_card.dart';


class CurrentGameResultPage extends StatelessWidget {

  final CurrentGameResultController _currentGameResultController =
      Get.find<CurrentGameResultController>();
  final MasterController _masterController = Get.find<MasterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.amber,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Text(_masterController.userCurrentGame.value.name),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () {
                        return Container(
                          child: Text(
                            _currentGameResultController
                                        .mapMode.value.mapName ==
                                    ""
                                ? "LOADING_MESSAGE".tr
                                : _currentGameResultController
                                    .mapMode.value.mapName,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    "${_currentGameResultController.getCurrentGameMinutes()} Min",
                  ),
                ),
                _detachTeams(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _detachTeams() {
    return Column(
      children: [
        Obx(() {
          return _teamCard(_currentGameResultController.blueTeam,
              _currentGameResultController.blueTeamBannedChamp);
        }),
        Container(
          height: 30,
          color: Colors.greenAccent,
        ),
        Obx(() {
          return _teamCard(_currentGameResultController.redTeam,
              _currentGameResultController.redTeamBannedChamp);
        }),
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
        return CurrentGameParticipantCard(participants[index], bannedChampions[index]);
      },
    );
  }
}

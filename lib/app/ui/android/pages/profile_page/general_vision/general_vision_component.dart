import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/profile_general_vision/general_vision_controller.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';

class GeneralVisionComponent extends StatefulWidget {
  final MatchDetail matchDetail;
  final Participant participant;

  GeneralVisionComponent(
      {Key? key, required this.matchDetail, required this.participant})
      : super(key: key);

  @override
  State<GeneralVisionComponent> createState() => _GeneralVisionComponentState();
}

class _GeneralVisionComponentState extends State<GeneralVisionComponent> {
  final GeneralVisionController _generalVisionController =
      Get.put(GeneralVisionController());

  // final CurrentGameParticipantController _currentGameParticipantController =
  //     CurrentGameParticipantController();
  // final MasterController _masterController = Get.find<MasterController>();

  @override
  void initState() {
    _generalVisionController.startInitialData(
        widget.matchDetail, widget.participant);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
        ),
        color: _generalVisionController.participant.win
            ? Colors.blue.withOpacity(0.5)
            : Colors.red.withOpacity(0.5),
      ),
      child: _generalVisionController.isLoadingTeamInfo.value
          ? DotsLoading()
          : ListView(
              children: [
                _header(),
                _gameInfo(),
                _listTeams(),
              ],
            ),
    );
  }

  _header() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 15),
      child: Text(
        _generalVisionController.getWinOrLoseHeaderText(context),
        style: GoogleFonts.montserrat(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  _listTeams() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _generalVisionController.matchDetail.matchInfo.teams.length,
        itemBuilder: (_, index) {
          return _teamCard(
              _generalVisionController.matchDetail.matchInfo.teams[index],
              _generalVisionController
                          .matchDetail.matchInfo.teams[index].teamId ==
                      100
                  ? _generalVisionController.blueTeam
                  : _generalVisionController.redTeam);
        },
      ),
    );
  }

  _teamCard(Team team, RxList<Participant> participants) {
    return Container(
      margin: EdgeInsets.only(top: 50),
     // color: Colors.green,
      height: 800,
      child: Column(
        children: [
          _teamHeader(team),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: participants.length,
            itemBuilder: (_, index) {
              return _participantCardDetail(
                participant: participants[index],
              );
            },
          ),
          _teamChampionBanned(team),
        ],
      ),
    );
  }

  _gameInfo() {
    return Container(
      color: Colors.cyan,
      child: Text(_generalVisionController.currentMapToShow.value.description),
    );
  }

  _teamChampionBanned(Team team) {
    return Container(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: team.bans.length,
        itemBuilder: (_, index) {
          return _bannedChampionCard(team.bans[index]);
        },
      ),
    );
  }

  _bannedChampionCard(Ban ban) {
    return Container(
      child: Text("CHAMP>" + ban.championId.toString()),
    );
  }

  _teamHeader(Team team) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconTeamHeader(_generalVisionController.getBaronIcon(), team.objectives.baron.kills.toString(), team.teamId),
          _iconTeamHeader(_generalVisionController.getDragonIcon(), team.objectives.dragon.kills.toString(), team.teamId),
          _iconTeamHeader(_generalVisionController.getTowerIcon(), team.objectives.tower.kills.toString(), team.teamId),
          _iconTeamHeader(_generalVisionController.getKillIcon(), team.objectives.champion.kills.toString(), team.teamId)
        ],
      ),
    );
  }

  _iconTeamHeader(String icon, String value, int teamId){
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 20,
          child: Image.network(
            icon,
            fit: BoxFit.cover,
            color: teamId == 100 ? Colors.blue : Colors.red[300],
          ),
        ),
        Text(value),
      ],
    );
  }

  _participantCardDetail({required Participant participant}) {
    return Container(
      height: 50,
      color: Colors.blue,
      child: FittedBox(child: Text(participant.summonerName)),
    );
  }
}

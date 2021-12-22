import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/profile_general_vision/general_vision_controller.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';

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
  final CurrentGameParticipantController _currentGameParticipantController =
      CurrentGameParticipantController();
  final MasterController _masterController = Get.find<MasterController>();

  @override
  void initState() {
    _generalVisionController.startInitialData(
        widget.matchDetail, widget.participant);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
        ),
        color: _generalVisionController.participant.win
            ? Colors.blue.withOpacity(0.5)
            : Colors.red.withOpacity(0.5),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _header(),
            _listTeams(),
          ],
        ),
      ),
    );
  }

  _header() {
    return Container(
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
      height: 600,
      child: Expanded(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _generalVisionController.matchDetail.matchInfo.teams.length,
          itemBuilder: (_, index) {
            return _teamCard(
                _generalVisionController.matchDetail.matchInfo.teams[index],
                _generalVisionController.matchDetail.matchInfo.teams[index]
                            .objectives.teamId ==
                        100
                    ? _generalVisionController.blueTeam
                    : _generalVisionController.redTeam);
          },
        ),
      ),
    );
  }

  _teamCard(Team team, RxList<Participant> participants) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      color: Colors.green,
      height: 200,
      child: Column(
        children: [
          _teamHeader(team),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: participants.length,
              itemBuilder: (_, index) {
                return _participantCardDetail(
                  participant: participants[index],
                );
              },
            ),
          ),
          _teamChampionBanned(team),
        ],
      ),
    );
  }

  _teamChampionBanned(Team team){
    return Container(
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemCount: team.bans.length,
          itemBuilder: (_, index) {
            return _bannedChampionCard(team.bans[index]);
          },
        ),
      ),
    );
  }

  _bannedChampionCard(Ban ban){
    return Container(
      child: Text("CHAMP>" + ban.championId.toString()),
    );
  }

  _teamHeader(Team team) {
    return Container(
      child: Row(
        children: [
          Text("BARON" + team.objectives.baron.kills.toString()),
          Text("RiftHeraldo" + team.objectives.riftHerald.kills.toString()),
          Text("Dragon" + team.objectives.dragon.kills.toString()),
          Text("Tower" + team.objectives.tower.kills.toString()),
          Text("Champion" + team.objectives.champion.kills.toString()),
        ],
      ),
    );
  }

  _participantCardDetail({required Participant participant}) {
    return Container(
      height: 38,
      color: Colors.blue,
      child: Text(participant.summonerId),
    );
  }
}

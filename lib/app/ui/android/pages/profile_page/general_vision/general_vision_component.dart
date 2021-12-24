import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/profile_general_vision/general_vision_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/profile_result_controller/profile_result_game_detail_controller.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';

class GeneralVisionComponent extends StatefulWidget {
  final MatchDetail matchDetail;
  final String primaryStylePerk;
  final String subStylePerk;
  final Participant participant;

  GeneralVisionComponent(
      {Key? key,
      required this.matchDetail,
      required this.participant,
      this.primaryStylePerk = "",
      this.subStylePerk = ""})
      : super(key: key);

  @override
  State<GeneralVisionComponent> createState() => _GeneralVisionComponentState();
}

class _GeneralVisionComponentState extends State<GeneralVisionComponent> {
  final GeneralVisionController _generalVisionController =
      Get.put(GeneralVisionController());
  final CurrentGameParticipantController _currentGameParticipantController =
      CurrentGameParticipantController();
  final ProfileResultGameDetailController _profileResultGameDetailController =
      ProfileResultGameDetailController();

  static const BLUE_TEAM = 100;

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
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _generalVisionController.matchDetail.matchInfo.teams.length,
        itemBuilder: (_, index) {
          return _teamCard(
              _generalVisionController.matchDetail.matchInfo.teams[index],
              _generalVisionController
                          .matchDetail.matchInfo.teams[index].teamId ==
                      BLUE_TEAM
                  ? _generalVisionController.blueTeam
                  : _generalVisionController.redTeam);
        },
      ),
    );
  }

  _teamCard(Team team, RxList<Participant> participants) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.green,
      height: 370,
      child: Column(
        children: [
          _teamHeader(team),
          ListView.builder(
            padding: EdgeInsets.zero,
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
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 15),
      color: Colors.cyan,
      child: Text(_generalVisionController.currentMapToShow.value.description),
    );
  }

  _teamChampionBanned(Team team) {
    return Column(
      children: [
        Container(
          child: Text("Bans"),
        ),
        Container(
          height: 50,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: team.bans.length,
            itemBuilder: (_, index) {
              return _bannedChampionCard(team.bans[index]);
            },
          ),
        ),
      ],
    );
  }

  _bannedChampionCard(Ban ban) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: ban.championId > 0
          ? Image.network(
              _currentGameParticipantController.getChampionBadgeUrl(
                ban.championId.toString(),
              ),
              width: MediaQuery.of(context).size.width / 14,
            )
          : Image.asset(
              imageNoChampion,
              width: MediaQuery.of(context).size.width / 14,
            ),
    );
  }

  _teamHeader(Team team) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconTeamHeader(_generalVisionController.getBaronIcon(),
              team.objectives.baron.kills.toString(), team.teamId),
          _iconTeamHeader(_generalVisionController.getDragonIcon(),
              team.objectives.dragon.kills.toString(), team.teamId),
          _iconTeamHeader(_generalVisionController.getTowerIcon(),
              team.objectives.tower.kills.toString(), team.teamId),
          _KDAText(team),
        ],
      ),
    );
  }

  _iconTeamHeader(String icon, String value, int teamId) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 20,
          child: Image.network(
            icon,
            fit: BoxFit.cover,
            color: teamId == BLUE_TEAM ? Colors.blue : Colors.red[300],
          ),
        ),
        Text(value),
      ],
    );
  }

  _KDAText(Team team) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 20,
          child: Image.network(
            _generalVisionController.getKillIcon(),
            fit: BoxFit.cover,
            color: team.teamId == BLUE_TEAM ? Colors.blue : Colors.red[300],
          ),
        ),
        team.teamId == BLUE_TEAM
            ? Text(team.objectives.champion.kills.toString() +
                "/" +
                _generalVisionController
                    .matchDetail.matchInfo.computedMatchDeathBlueTeam
                    .toString() +
                "/" +
                _generalVisionController
                    .matchDetail.matchInfo.computedMatchAssistBlueTeam
                    .toString())
            : Text(team.objectives.champion.kills.toString() +
                "/" +
                _generalVisionController
                    .matchDetail.matchInfo.computedMatchDeathRedTeam
                    .toString() +
                "/" +
                _generalVisionController
                    .matchDetail.matchInfo.computedMatchAssistRedTeam
                    .toString()),
      ],
    );
  }

  _participantCardDetail({required Participant participant}) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 50,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _userChampionDetail(participant),
              Container(
                margin: EdgeInsets.only(top: 10, right: 5),
                child: Column(
                  children: [
                    _spellIcon(participant.summoner1Id.toString()),
                    _spellIcon(participant.summoner2Id.toString()),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, right: 5),
                child: Column(
                  children: [
                    _perkIcon(participant.perk.styles[0].selections[0].perk
                        .toString()),
                    _perkStyleIcon(participant.perk.styles[1].style.toString()),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(child: Text(participant.summonerName)),
                  _userKDA(participant),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 10, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _itemBase(item: participant.item0),
                    _itemBase(item: participant.item1),
                    _itemBase(item: participant.item2),
                    _itemBase(item: participant.item3),
                    _itemBase(item: participant.item4),
                    _itemBase(item: participant.item5),
                    _itemBase(item: participant.item6, last: true),
                  ],
                ),
                Row(
                  children: [
                    Text(participant.totalMinionsKilled.toString()),
                    Text("/"),
                    Text(participant.goldEarned.toString() + "k"),
                    Container(
                      child: Text("Dmg " +
                          participant.totalDamageDealtToChampions.toString()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _itemBase({required dynamic item, bool last = false}) {
    return Container(
      height: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 20 : 12,
      width: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 20 : 12,
      margin: EdgeInsets.only(left: last ? 2 : 0),
      child: Container(
        child: item > 0
            ? Image.network(
                _profileResultGameDetailController.getItemUrl(item.toString()),
                width: MediaQuery.of(context).size.width / 16,
                fit: BoxFit.cover,
              )
            : Image.asset(
                imageIconItemNone,
                width: MediaQuery.of(context).size.width / 16,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  _userKDA(Participant participant) {
    return Container(
      child: Text(
        participant.kills.toString() +
            "/" +
            participant.deaths.toString() +
            "/" +
            participant.assists.toString(),
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  _userChampionDetail(Participant participant) {
    return Container(
      child: participant.championId > 0
          ? Stack(
              children: [
                Image.network(
                  _currentGameParticipantController.getChampionBadgeUrl(
                    participant.championId.toString(),
                  ),
                  width: 30,
                ),
                Positioned(
                  left: 19,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black54,
                    ),
                    child: Text(
                      participant.champLevel.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ),
              ],
            )
          : Image.asset(
              imageNoChampion,
              width: 30,
            ),
    );
  }

  _spellIcon(String spellId) {
    return spellId.isNotEmpty
        ? Image.network(
            _currentGameParticipantController.getSpellUrl(
              spellId,
            ),
            width: 15,
          )
        : Image.asset(
            imageNoChampion,
            width: 20,
          );
  }

  _perkStyleIcon(String perkIconName) {
    return perkIconName.isNotEmpty
        ? Image.network(
            _generalVisionController.getPerkStyleUrl(
              perkIconName,
            ),
            width: 15,
          )
        : Image.asset(
            imageNoChampion,
            width: 20,
          );
  }

  _perkIcon(String perkIconName) {
    return perkIconName.isNotEmpty
        ? Image.network(
            _generalVisionController.getPerkUrl(
              perkIconName,
            ),
            width: 15,
          )
        : Image.asset(
            imageNoChampion,
            width: 20,
          );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/core/widgets/dots_loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_controller/general_vision_controller.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_controller/profile_result_game_detail_controller.dart';

import '../../../../../layers/presentation/controllers/queues_controller.dart';

class GeneralVisionComponent extends StatefulWidget {
  final MatchDetail matchDetail;
  final String primaryStylePerk;
  final String subStylePerk;
  final Participant participant;
  final formatter = NumberFormat.decimalPattern('hi');

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
  final QueuesController _queuesController = GetIt.I.get<QueuesController>();

  static const BLUE_TEAM = 100;

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
          color: Colors.white,
        ),
        child: _generalVisionController.isLoadingTeamInfo.value
            ? DotsLoading()
            : Column(
                children: [
                  _header(),
                  Expanded(
                    child: ListView(
                      children: [
                        _gameInfo(),
                        _listTeams(),
                      ],
                    ),
                  ),
                ],
              ));
  }

  _header() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 25),
          child: Text(
            _generalVisionController.getWinOrLoseHeaderText(context),
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Positioned(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              //padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(32),
              ),
              height: 30,
              width: 30,
              margin: EdgeInsets.only(left: 15, top: 20),
              child: Icon(
                Icons.clear,
                color: Colors.black,
                size: 15,
              ),
            ),
          ),
        ),
      ],
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
                  ? _generalVisionController.blueTeam.value
                  : _generalVisionController.redTeam.value);
        },
      ),
    );
  }

  _teamCard(Team team, List<Participant> participants) {
    return Container(
      color: team.teamId == BLUE_TEAM ? Colors.blue[200] : Colors.red[200],
      height: 520,
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
      child: Text(_queuesController.currentMapToShow.value.description),
    );
  }

  _teamChampionBanned(Team team) {
    return Column(
      children: [
        Container(
          child: Text(AppLocalizations.of(context)!.bans),
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
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 20,
                child: Image.network(
                  _generalVisionController.getHeraldIcon(),
                  fit: BoxFit.cover,
                ),
              ),
              Text(team.objectives.riftHerald.kills.toString()),
            ],
          ),
          _kdaText(team),
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
            color: Colors.blueGrey[900],
          ),
        ),
        Text(value),
      ],
    );
  }

  _kdaText(Team team) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 20,
          child: Image.network(
            _generalVisionController.getKillIcon(),
            fit: BoxFit.cover,
            color: Colors.blueGrey[900],
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
      height: 78,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _userChampionDetail(participant),
              Container(
                margin: EdgeInsets.only(top: 24, right: 5),
                child: Column(
                  children: [
                    _spellIcon(participant.summoner1Id.toString()),
                    _spellIcon(participant.summoner2Id.toString()),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 23, right: 5),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    height: 20,
                    child: FittedBox(
                      child: Text(
                        participant.summonerName,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  _userKDA(participant),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 8, top: 22),
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
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Container(
                              width: 13,
                              child: Image.network(
                                  _generalVisionController.getMinionUrl()),
                            ),
                            Text(
                              participant.totalMinionsKilled.toString(),
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Container(
                              width: 13,
                              child: Image.network(
                                  _generalVisionController.getGoldIconUrl()),
                            ),
                            Text(
                              widget.formatter.format(participant.goldEarned),
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5, top: 4),
                        child: Column(
                          children: [
                            Image.network(
                              _generalVisionController.getCriticIcon(),
                              color: Colors.red,
                              height: 8,
                            ),
                            Text(
                              widget.formatter.format(
                                  participant.totalDamageDealtToChampions),
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
      height: 20,
      width: 20,
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
                  height: 30,
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

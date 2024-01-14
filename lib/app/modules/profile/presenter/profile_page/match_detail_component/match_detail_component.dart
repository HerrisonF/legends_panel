import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/match_detail_repository.dart';
import 'package:legends_panel/app/modules/profile/domain/models/match_detail_model.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/match_detail_component/match_detail_component_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchDetailComponent extends StatefulWidget {
  final MatchDetailModel matchDetail;

  MatchDetailComponent({Key? key, required this.matchDetail}) : super(key: key);

  @override
  State<MatchDetailComponent> createState() => _MatchDetailComponentState();
}

class _MatchDetailComponentState extends State<MatchDetailComponent> {
  late MatchDetailComponentController _matchDetailComponentController;
  late GeneralController _generalController;

  final formatter = NumberFormat.decimalPattern('hi');

  static const BLUE_TEAM = 100;

  @override
  void initState() {
    _matchDetailComponentController = MatchDetailComponentController(
      matchDetailRepository: MatchDetailRepository(logger: GetIt.I<Logger>()),
      matchDetail: widget.matchDetail,
    );
    _generalController = GetIt.I<GeneralController>();
    _matchDetailComponentController.detachParticipantsIntoTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: ValueListenableBuilder(
        valueListenable: _matchDetailComponentController.isLoadingTeamInfo,
        builder: (context, isLoading, _) {
          return isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    _header(),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              _generalController.lolConstantsModel
                                  .getMapNameById(
                                      mapId: widget.matchDetail.info!.mapId),
                            ),
                          ),
                          _listTeams(),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  _header() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 24),
          child: Text(
            getWinOrLoseHeaderText(),
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(32),
              ),
              height: 30,
              width: 30,
              margin: EdgeInsets.only(left: 20, top: 20),
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

  Widget _listTeams() {
    return Container(
      child: Column(
        children: widget.matchDetail.info!.teams
            .map(
              (e) => _teamCard(
                team: e,
                participants: e.teamId == BLUE_TEAM
                    ? _matchDetailComponentController.blueTeam.value
                    : _matchDetailComponentController.redTeam.value,
              ),
            )
            .toList(),
      ),
    );
  }

  Container _teamCard({
    required TeamModel team,
    required List<ParticipantModel> participants,
  }) {
    return Container(
      color: team.teamId == BLUE_TEAM ? Colors.blue[300] : Colors.red[300],
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: _kdaText(team),
          ),
          _teamHeader(team: team),
          Column(
            children: participants
                .map((e) => _participantCardDetail(
                      participant: e,
                    ))
                .toList(),
          ),
          _teamChampionBanned(
            banChamps: team.bans,
          ),
        ],
      ),
    );
  }

  _teamHeader({required TeamModel team}) {
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _iconTeamHeader(
            _matchDetailComponentController.getBaronIcon(),
            team.objetivos.baron.kills.toString(),
          ),
          _iconTeamHeader(
            _matchDetailComponentController.getDragonIcon(),
            team.objetivos.dragon.kills.toString(),
          ),
          _iconTeamHeader(
            _matchDetailComponentController.getTowerIcon(),
            team.objetivos.tower.kills.toString(),
          ),
          _iconTeamHeader(
            _matchDetailComponentController.getInhibitorIcon(),
            team.objetivos.inhibitor.kills.toString(),
          ),
          _iconTeamHeader(
            _matchDetailComponentController.getHeraldIcon(),
            team.objetivos.riftHerald.kills.toString(),
          ),
        ],
      ),
    );
  }

  _teamChampionBanned({
    required List<BanModel> banChamps,
  }) {
    return Column(
      children: [
        Container(
          child: Text(
            AppLocalizations.of(context)!.bans,
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: banChamps
                .map(
                  (e) => _bannedChampionCard(
                    ban: e,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Container _bannedChampionCard({required BanModel ban}) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: ban.championId > 0
          ? Image.network(
              _generalController.getChampionBadgeUrl(ban.championId),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.black45,
                );
              },
            )
          : SizedBox.shrink(),
    );
  }

  Container _iconTeamHeader(String icon, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 20,
      child: Column(
        children: [
          Image.network(
            icon,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 5,
          ),
          Text(value),
        ],
      ),
    );
  }

  _kdaText(TeamModel team) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Image.network(
            _matchDetailComponentController.getKillIcon(),
            fit: BoxFit.cover,
            color: Colors.black,
          ),
        ),
        team.teamId == BLUE_TEAM
            ? Text(team.objetivos.champion.kills.toString() +
                "/" +
                _matchDetailComponentController
                    .matchDetail.info!.computedMatchDeathBlueTeam
                    .toString() +
                "/" +
                _matchDetailComponentController
                    .matchDetail.info!.computedMatchAssistBlueTeam
                    .toString())
            : Text(team.objetivos.champion.kills.toString() +
                "/" +
                _matchDetailComponentController
                    .matchDetail.info!.computedMatchDeathRedTeam
                    .toString() +
                "/" +
                _matchDetailComponentController
                    .matchDetail.info!.computedMatchAssistRedTeam
                    .toString()),
      ],
    );
  }

  Container _participantCardDetail({
    required ParticipantModel participant,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _userChampionDetail(participant: participant),
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Column(
                  children: [
                    _spellIcon(spellId: participant.summoner1Id),
                    _spellIcon(spellId: participant.summoner2Id),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Column(
                  children: participant.perks!.styles
                      .map(
                        (e) => _perkStyleIcon(perkStyleId: e.style),
                      )
                      .toList(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      participant.summonerName + participant.riotIdTagline,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _userKDA(participant: participant),
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
                    _itemBase(item: participant.item6),
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
                                _matchDetailComponentController.getMinionUrl(),
                              ),
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
                                _matchDetailComponentController
                                    .getGoldIconUrl(),
                              ),
                            ),
                            Text(
                              formatter.format(participant.goldEarned),
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
                              _matchDetailComponentController.getCriticIcon(),
                              color: Colors.red,
                              height: 8,
                            ),
                            Text(
                              formatter.format(
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

  Container _perkStyleIcon({required int perkStyleId}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Image.network(
        _generalController.getPerkStyleBadgeUrl(
          perkId: perkStyleId,
        ),
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.black45,
          );
        },
        width: 15,
        height: 15,
      ),
    );
  }

  _itemBase({required int item}) {
    return Container(
      height: 20,
      width: 20,
      child: item > 0
          ? Image.network(
              _generalController.getItemUrl(itemId: item),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.black45,
                );
              },
            )
          : Container(
              color: Colors.black45,
            ),
    );
  }

  _userKDA({
    required ParticipantModel participant,
  }) {
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

  _userChampionDetail({
    required ParticipantModel participant,
  }) {
    return Container(
      child: participant.championId > 0
          ? Stack(
              children: [
                Image.network(
                  _generalController
                      .getChampionBadgeUrl(participant.championId),
                  width: 30,
                  height: 30,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black45,
                    );
                  },
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              color: Colors.black45,
            ),
    );
  }

  _spellIcon({required int spellId}) {
    return Image.network(
      _generalController.getSpellBadgeUrl(
        spellId,
      ),
      width: 15,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.black45,
        );
      },
    );
  }

  String getWinOrLoseHeaderText() {
    if (widget.matchDetail.info!.currentParticipant!.win) {
      if (widget.matchDetail.info!.currentParticipant!.teamId == BLUE_TEAM) {
        return "${AppLocalizations.of(context)!.gameVictoriousBlueTeam}";
      } else {
        return "${AppLocalizations.of(context)!.gameVictoriousRedTeam}";
      }
    } else {
      if (widget.matchDetail.info!.currentParticipant!.teamId == BLUE_TEAM) {
        return "${AppLocalizations.of(context)!.gameDefeatedBlueTeam}";
      } else {
        return "${AppLocalizations.of(context)!.gameDefeatedRedTeam}";
      }
    }
  }
}

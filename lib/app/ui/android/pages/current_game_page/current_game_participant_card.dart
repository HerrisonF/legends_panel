import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';

class CurrentGameParticipantCard extends StatefulWidget {
  final CurrentGameParticipant participant;
  final String region;

  CurrentGameParticipantCard({required this.participant, required this.region});

  @override
  _CurrentGameParticipantCardState createState() =>
      _CurrentGameParticipantCardState();
}

class _CurrentGameParticipantCardState
    extends State<CurrentGameParticipantCard> {
  final CurrentGameParticipantController _currentGameParticipantController =
      CurrentGameParticipantController();
  final MasterController _masterController = Get.find<MasterController>();

  static const BLUE_TEAM = 100;

  @override
  void initState() {
    super.initState();
    _currentGameParticipantController.getUserTier(
        widget.participant.summonerId, widget.region);
    _currentGameParticipantController.getSpectator(
        widget.participant.summonerId, widget.region);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.participant.teamId == BLUE_TEAM ? Colors.blue.withOpacity(0.1) : Colors.red.withOpacity(0.1),
      padding: EdgeInsets.symmetric(
        horizontal: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 5 : 3,
        vertical: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 10 : 5,
      ),
      child: Row(
        children: [
          _playerChampionBadge(),
          _playerSpells(),
          _playerPerks(),
          _summonerName(),
          _userTierNameAndSymbol(),
          _playerWinRate(),
          _bannedChampion(),
        ],
      ),
    );
  }

  _playerChampionBadge() {
    return Image.network(
      _currentGameParticipantController.getChampionBadgeUrl(
        widget.participant.championId.toString(),
      ),
      width: MediaQuery.of(context).size.width / 10,
    );
  }

  Column _playerSpells() {
    return Column(
      children: [
        _currentGameParticipantController.getSpellUrl(
          widget.participant.spell1Id.toString(),
        ).isNotEmpty ?
        Image.network(
          _currentGameParticipantController.getSpellUrl(
            widget.participant.spell1Id.toString(),
          ),
          width: MediaQuery.of(context).size.width / 21,
        ) : SizedBox.shrink(),
        _currentGameParticipantController.getSpellUrl(
          widget.participant.spell2Id.toString(),
        ).isNotEmpty ?
        Image.network(
          _currentGameParticipantController.getSpellUrl(
            widget.participant.spell2Id.toString(),
          ),
          width: MediaQuery.of(context).size.width / 21,
        ) : SizedBox.shrink(),
      ],
    );
  }

  _playerPerks(){
    return Container(
      margin: EdgeInsets.only(left: 5),
      child: Column(
        children: [
          _currentGameParticipantController.getFirsPerkUrl(widget.participant.perks).isNotEmpty ?
          Image.network(
            _currentGameParticipantController.getFirsPerkUrl(widget.participant.perks),
            width: MediaQuery.of(context).size.width / 22,
          ) : SizedBox.shrink(),
          _currentGameParticipantController.getPerkStyleUrl(widget.participant.perks).isNotEmpty ?
          Image.network(
            _currentGameParticipantController.getPerkStyleUrl(widget.participant.perks),
            width: MediaQuery.of(context).size.width / 28,
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }

  Container _summonerName() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 70,
      child: Text(
        widget.participant.summonerName,
        style: GoogleFonts.montserrat(
          fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne()
              ? 12
              : 8,
          color: Colors.white,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _bannedChampion() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: widget.participant.currentGameBannedChampion.championId > 0
          ? Image.network(
              _currentGameParticipantController.getChampionBadgeUrl(
                widget.participant.currentGameBannedChampion.championId
                    .toString(),
              ),
              width: MediaQuery.of(context).size.width / 14,
            )
          : Image.asset(
              imageNoChampion,
              width: MediaQuery.of(context).size.width / 14,
            ),
    );
  }

  _playerWinRate() {
    return Obx(() {
      return _currentGameParticipantController
              .soloUserTier.value.winRate.isNotEmpty
          ? Container(
              child: Text(
                "WR " +
                    _currentGameParticipantController
                        .soloUserTier.value.winRate +
                    "%",
                style: GoogleFonts.montserrat(
                  fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 8 : 6,
                  color: Colors.white,
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(left: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 10 : 0, right: MediaQuery.of(context).size.height > 800 ? 20 : 0),
              child: Text(
                " - ",
                style: GoogleFonts.montserrat(
                  fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 8 : 6,
                  color: Colors.white,
                ),
              ),
            );
    });
  }

  Container _userTierNameAndSymbol() {
    return Container(
      margin: EdgeInsets.only(
          right: 5, left: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 10 : 0),
      child: Row(
        children: [_userTierSymbol(), _userTierName()],
      ),
    );
  }

  Column _userTierName() {
    return Column(
      children: [
        Obx(() {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 5 : 0),
            width: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 80 : 60,
            child: _currentGameParticipantController
                    .soloUserTier.value.tier.isNotEmpty
                ? Text(
                    _currentGameParticipantController.soloUserTier.value.tier +
                        " " +
                        _currentGameParticipantController
                            .soloUserTier.value.rank,
                    style: GoogleFonts.montserrat(
                      fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 8 : 6,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(
                    "UNRANKED",
                    style: GoogleFonts.montserrat(
                      fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 8 : 6,
                      color: Colors.white,
                    ),
                  ),
          );
        }),
        Obx(() {
          return Container(
            alignment: Alignment.center,
            width: 80,
            child: _currentGameParticipantController
                    .soloUserTier.value.tier.isNotEmpty
                ? Text(
                    "(" +
                        _currentGameParticipantController
                            .soloUserTier.value.leaguePoints
                            .toString() +
                        "LP)",
                    style: GoogleFonts.montserrat(
                      fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                          ? 8
                          : 6,
                      color: Colors.white,
                    ),
                  )
                : SizedBox.shrink(),
          );
        }),
      ],
    );
  }

  Container _userTierSymbol() {
    return Container(
      margin: EdgeInsets.only(right: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 5 : 0),
      child: Obx(() {
        return _currentGameParticipantController
                .soloUserTier.value.tier.isNotEmpty
            ? Image.network(
                _currentGameParticipantController.getUserTierImage(
                  _currentGameParticipantController.soloUserTier.value.tier,
                ),
                width: MediaQuery.of(context).size.width / 22,
              )
            : Image.asset(
                imageUnranked,
                width: MediaQuery.of(context).size.width / 22,
              );
      }),
    );
  }
}

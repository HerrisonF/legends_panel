import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';

class CurrentGameParticipantCard extends StatefulWidget {
  final CurrentGameParticipant? participant;
  final CurrentGameBannedChampion? bannedChampion;
  final String? region;

  CurrentGameParticipantCard(
      {required this.participant, this.bannedChampion, required this.region});

  @override
  _CurrentGameParticipantCardState createState() =>
      _CurrentGameParticipantCardState();
}

class _CurrentGameParticipantCardState
    extends State<CurrentGameParticipantCard> {
  final CurrentGameParticipantController _currentGameParticipantController =
      CurrentGameParticipantController();

  @override
  void initState() {
    super.initState();
    _currentGameParticipantController.getUserTier(
        widget.participant!.summonerId, widget.region!);
    _currentGameParticipantController.getSpectator(
        widget.participant!.summonerId, widget.region!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      padding: EdgeInsets.symmetric(horizontal:5, vertical: MediaQuery.of(context).size.height > 800 ? 10 : 5),
      child: Row(
        children: [
          _playerChampionBadge(),
          _playerSpells(),
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
        widget.participant!.championId.toString(),
      ),
      width: MediaQuery.of(context).size.width / 10,
    );
  }

  Column _playerSpells() {
    return Column(
      children: [
        Image.network(
          _currentGameParticipantController.getSpellUrl(
            widget.participant!.spell1Id.toString(),
          ),
          width: MediaQuery.of(context).size.width / 21.5,
        ),
        Image.network(
          _currentGameParticipantController.getSpellUrl(
            widget.participant!.spell2Id.toString(),
          ),
          width: MediaQuery.of(context).size.width / 21.5,
        ),
      ],
    );
  }

  Container _summonerName() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 70,
      child: Text(
        widget.participant!.summonerName,
        style: GoogleFonts.montserrat(
          fontSize: MediaQuery.of(context).size.height >
                  MasterController.NEXUS_ONE_SCREEN_HEIGHT
              ? 12
              : 8,
          color: Colors.white,
        ),
      ),
    );
  }

  _bannedChampion() {
    if(widget.bannedChampion != null){
      return Container(
        margin: const EdgeInsets.only(left: 10),
        child: widget.bannedChampion!.championId > 0
            ? Image.network(
          _currentGameParticipantController.getChampionBadgeUrl(
            widget.bannedChampion!.championId.toString(),
          ),
          width: MediaQuery.of(context).size.width / 14,
        )
            : Image.asset(
          imageNoChampion,
          width: MediaQuery.of(context).size.width / 14,
        ),
      );
    }
    return Image.asset(
      imageNoChampion,
      width: MediaQuery.of(context).size.width / 14,
    );
  }

  _playerWinRate() {
    return Obx(() {
      return _currentGameParticipantController
              .soloUserTier.value.winRate.isNotEmpty
          ? Container(
              child: Text(
                "WR " + _currentGameParticipantController.soloUserTier.value.winRate +
                    "%",
                style: GoogleFonts.montserrat(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            )
          : DotsLoading();
    });
  }

  Container _userTierNameAndSymbol() {
    return Container(
      margin: EdgeInsets.only(right: 5, left: MediaQuery.of(context).size.height > 800 ? 10 : 0),
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
            margin: const EdgeInsets.only(left: 5),
            width: 80,
            child: _currentGameParticipantController
                    .soloUserTier.value.tier.isNotEmpty
                ? Text(
                    _currentGameParticipantController.soloUserTier.value.tier +
                        " " +
                        _currentGameParticipantController
                            .soloUserTier.value.rank,
                    style: GoogleFonts.montserrat(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    "UNRANKED",
                    style: GoogleFonts.montserrat(
                      fontSize: 8,
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
                      fontSize: MediaQuery.of(context).size.height >
                              MasterController.NEXUS_ONE_SCREEN_HEIGHT
                          ? 12
                          : 8,
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
      margin: const EdgeInsets.only(right: 5),
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

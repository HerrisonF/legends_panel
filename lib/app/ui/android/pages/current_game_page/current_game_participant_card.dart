import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';

class CurrentGameParticipantCard extends StatefulWidget {
  final CurrentGameParticipant participant;
  final CurrentGameBannedChampion bannedChampion;
  final String region;

  CurrentGameParticipantCard(
      this.participant, this.bannedChampion, this.region);

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
        widget.participant.summonerId, widget.region);
    _currentGameParticipantController.getSpectator(
        widget.participant.summonerId, widget.region);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _playerChampionBadge(),
          _spells(),
          _summonerName(),
          _userTier(),
          _playerTier(),
          _bannedChampion(),
        ],
      ),
    );
  }

  Container _bannedChampion() {
    return Container(
      child: Container(
        child: widget.bannedChampion.championId > 0
            ? Image.network(
                _currentGameParticipantController.getChampionBadgeUrl(
                  widget.bannedChampion.championId.toString(),
                ),
                width: 30,
                height: 30,
              )
            : Image.asset(
                imageNoChampion,
                width: 30,
                height: 30,
              ),
      ),
    );
  }

  Obx _playerTier() {
    return Obx(() {
      return _currentGameParticipantController
              .soloUserTier.value.winRate.isNotEmpty
          ? Container(
              child: Text(
                _currentGameParticipantController.soloUserTier.value.winRate +
                    "%",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            )
          : DotsLoading();
    });
  }

  Container _userTier() {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 130,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Obx(() {
              return _currentGameParticipantController
                      .soloUserTier.value.tier.isNotEmpty
                  ? Image.network(
                      _currentGameParticipantController.getUserTierImage(
                          _currentGameParticipantController
                              .soloUserTier.value.tier),
                      width: 26,
                      height: 26,
                    )
                  : Image.asset(
                imageUnranked,
                width: 26,
                height: 26,
              );
            }),
          ),
          Column(
            children: [
              Obx(() {
                return Container(
                  margin: EdgeInsets.only(left: 5),
                  child: _currentGameParticipantController
                          .soloUserTier.value.tier.isNotEmpty
                      ? Text(
                          _currentGameParticipantController
                                  .soloUserTier.value.tier +
                              " " +
                              _currentGameParticipantController
                                  .soloUserTier.value.rank,
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                        )
                      : Text(
                    "UNRANKED",
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
              Obx(() {
                return Container(
                  child: _currentGameParticipantController
                          .soloUserTier.value.tier.isNotEmpty
                      ? Text(
                          "(" +
                              _currentGameParticipantController
                                  .soloUserTier.value.leaguePoints
                                  .toString() +
                              "LP)",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                        )
                      : SizedBox.shrink(),
                );
              }),
            ],
          )
        ],
      ),
    );
  }

  Container _summonerName() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: 65,
      child: Text(
        widget.participant.summonerName,
        style: GoogleFonts.montserrat(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  Column _spells() {
    return Column(
      children: [
        Container(
          child: Image.network(
            _currentGameParticipantController.getSpellUrl(
              widget.participant.spell1Id.toString(),
            ),
            width: 22,
            height: 22,
          ),
        ),
        Container(
          child: Image.network(
            _currentGameParticipantController.getSpellUrl(
              widget.participant.spell2Id.toString(),
            ),
            width: 22,
            height: 22,
          ),
        ),
      ],
    );
  }

  Container _playerChampionBadge() {
    return Container(
      child: Image.network(
        _currentGameParticipantController.getChampionBadgeUrl(
          widget.participant.championId.toString(),
        ),
        width: 45,
        height: 80,
      ),
    );
  }
}

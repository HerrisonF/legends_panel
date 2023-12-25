import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_participant_controller.dart';

class CurrentGameParticipantCard extends StatefulWidget {
  final ActiveGameParticipantModel participant;
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

  static const BLUE_TEAM = 100;

  @override
  void initState() {
    super.initState();
    //_currentGameParticipantController.getUserTier();
    _currentGameParticipantController.getSpectator(
        widget.participant.summonerId, widget.region);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.participant.teamId == BLUE_TEAM
          ? Colors.blue.withOpacity(0.12)
          : Colors.red.withOpacity(0.12),
      padding: EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _playerChampionBadge(),
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
    return Row(
      children: [
        Image.network(
          _currentGameParticipantController.getChampionBadgeUrl(
            widget.participant.championId.toString(),
          ),
          width: 36,
        ),
        _playerSpells(),
      ],
    );
  }

  Column _playerSpells() {
    return Column(
      children: [
        Container(
          width: 18,
          height: 18,
          child: _currentGameParticipantController
                  .getSpellUrl(
                    widget.participant.spell1Id.toString(),
                  )
                  .isNotEmpty
              ? Image.network(
                  _currentGameParticipantController.getSpellUrl(
                    widget.participant.spell1Id.toString(),
                  ),
                )
              : SizedBox.shrink(),
        ),
        Container(
          width: 18,
          height: 18,
          child: _currentGameParticipantController
                  .getSpellUrl(
                    widget.participant.spell2Id.toString(),
                  )
                  .isNotEmpty
              ? Image.network(
                  _currentGameParticipantController.getSpellUrl(
                    widget.participant.spell2Id.toString(),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  _playerPerks() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 2),
          width: 18,
          height: 18,
          child: _currentGameParticipantController
                  .getFirsPerkUrl()
                  .isNotEmpty
              ? Image.network(
                  _currentGameParticipantController
                      .getFirsPerkUrl(),
                )
              : SizedBox.shrink(),
        ),
        Container(
          width: 15,
          height: 15,
          child: _currentGameParticipantController
                  .getPerkStyleUrl()
                  .isNotEmpty
              ? Image.network(
                  _currentGameParticipantController
                      .getPerkStyleUrl(),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Container _summonerName() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      width: 70,
      child: Text(
        widget.participant.summonerName,
        style: GoogleFonts.montserrat(
          fontSize: 8,
          color: _isToPaintUserName() ? Colors.yellow : Colors.white,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  bool _isToPaintUserName() {
    // return _masterController.userForCurrentGame.name ==
    //     widget.participant.summonerName;
    return false;
  }

  _bannedChampion() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: widget.participant.championId > 0
          ? Image.network(
              _currentGameParticipantController.getChampionBadgeUrl(
                widget.participant.championId
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
    return ValueListenableBuilder(
        valueListenable: _currentGameParticipantController.soloUserTier,
        builder: (context, value, _) {
          return _currentGameParticipantController
                  .soloUserTier.value.winRate.isNotEmpty
              ? Container(
                  child: Text(
                    "WR " +
                        _currentGameParticipantController
                            .soloUserTier.value.winRate +
                        "%",
                    style: GoogleFonts.montserrat(
                      fontSize: 6,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    " - ",
                    style: GoogleFonts.montserrat(
                      fontSize: 6,
                      color: Colors.white,
                    ),
                  ),
                );
        });
  }

  _userTierNameAndSymbol() {
    return Row(
      children: [_userTierSymbol(), _userTierName()],
    );
  }

  Column _userTierName() {
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: _currentGameParticipantController.soloUserTier,
            builder: (context, value, _) {
              return Container(
                alignment: Alignment.center,
                width: 60,
                child: _currentGameParticipantController
                        .soloUserTier.value.tier.isNotEmpty
                    ? Text(
                        _currentGameParticipantController
                                .soloUserTier.value.tier +
                            " " +
                            _currentGameParticipantController
                                .soloUserTier.value.rank,
                        style: GoogleFonts.montserrat(
                          fontSize: 6,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : Container(
                        margin: EdgeInsets.only(right: 22),
                        child: Text(
                          "UNRANKED",
                          style: GoogleFonts.montserrat(
                            fontSize: 6,
                            color: Colors.white,
                          ),
                        ),
                      ),
              );
            }),
        ValueListenableBuilder(
            valueListenable: _currentGameParticipantController.soloUserTier,
            builder: (context, value, _) {
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
                          fontSize: 6,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox.shrink(),
              );
            }),
      ],
    );
  }

  _userTierSymbol() {
    return ValueListenableBuilder(
      valueListenable: _currentGameParticipantController.soloUserTier,
      builder: (context, value, _) {
        return Container(
          child: _currentGameParticipantController
                  .soloUserTier.value.tier.isNotEmpty
              ? Image.asset(
                  getUserTierImage(),
                  width: 18,
                )
              : Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Image.asset(
                    imageUnranked,
                    width: 17,
                  ),
                ),
        );
      },
    );
  }

  String getUserTierImage() {
    return _currentGameParticipantController.getUserTierImage(
      _currentGameParticipantController.soloUserTier.value.tier,
    );
  }
}

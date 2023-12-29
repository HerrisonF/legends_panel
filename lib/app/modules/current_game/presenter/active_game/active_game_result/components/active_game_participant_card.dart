import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/presenter/active_game/active_game_result/components/active_game_participant_controller.dart';

class ActiveGameParticipantCard extends StatefulWidget {
  final ActiveGameParticipantModel participant;
  final String region;
  final bool isToPaintUserName;

  ActiveGameParticipantCard({
    required this.participant,
    required this.region,
    required this.isToPaintUserName,
  });

  @override
  _ActiveGameParticipantCardState createState() =>
      _ActiveGameParticipantCardState();
}

class _ActiveGameParticipantCardState extends State<ActiveGameParticipantCard> {
  late ActiveGameParticipantController _activeGameParticipantController;

  static const BLUE_TEAM = 100;

  @override
  void initState() {
    _activeGameParticipantController = ActiveGameParticipantController(
      activeGameParticipantModel: widget.participant,
      generalController: GetIt.I<GeneralController>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.participant.teamId == BLUE_TEAM
            ? Colors.blue.withOpacity(0.5)
            : Colors.red.withOpacity(0.5),
        border: Border.all(color: Colors.black, width: 0.1),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 5,
      ),
      child: Row(
        children: [
          Expanded(
            child: _summonerChampionBadge(),
          ),
          Expanded(
            child: _summonerSpells(),
          ),
          Expanded(
            child: _summonerPerks(),
          ),
          Expanded(
            flex: 8,
            child: _summonerName(),
          ),
          //_userTierNameAndSymbol(),
          //_playerWinRate(),
        ],
      ),
    );
  }

  _summonerChampionBadge() {
    return Image.network(
      _activeGameParticipantController.generalController.getChampionBadgeUrl(
        widget.participant.championId,
      ),
      width: 36,
    );
  }

  Column _summonerSpells() {
    return Column(
      children: [
        Container(
          width: 18,
          height: 18,
          child: Image.network(
            _activeGameParticipantController.generalController.getSpellBadgeUrl(
              widget.participant.spell1Id,
            ),
            errorBuilder: (context, error, stackTrace) {
              return SizedBox.shrink();
            },
          ),
        ),
        Container(
          width: 18,
          height: 18,
          child: Image.network(
            _activeGameParticipantController.generalController.getSpellBadgeUrl(
              widget.participant.spell2Id,
            ),
            errorBuilder: (context, error, stackTrace) {
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  _summonerPerks() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 2),
          width: 18,
          height: 18,
          child: Image.network(
            _activeGameParticipantController.generalController.getPerkStyleBadgeUrl(
              perkId: widget.participant.perk!.perkSubStyle,
            ),
            errorBuilder: (context, error, stackTrace) {
              return SizedBox.shrink();
            },
          ),
        ),
        Container(
          width: 15,
          height: 15,
          child: Image.network(
            _activeGameParticipantController.generalController.getPerkStyleBadgeUrl(
              perkId: widget.participant.perk!.perkSubStyle,
            ),
            errorBuilder: (context, error, stackTrace) {
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Container _summonerName() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: Text(
        widget.participant.summonerName,
        style: GoogleFonts.montserrat(
          fontSize: 10,
          color: widget.isToPaintUserName ? Colors.yellow : Colors.white,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _playerWinRate() {
    return ValueListenableBuilder(
        valueListenable: _activeGameParticipantController.soloUserTier,
        builder: (context, value, _) {
          return _activeGameParticipantController
                  .soloUserTier.value.winRate.isNotEmpty
              ? Container(
                  child: Text(
                    "WR " +
                        _activeGameParticipantController
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

  // _userTierNameAndSymbol() {
  //   return Row(
  //     children: [_userTierSymbol(), _userTierName()],
  //   );
  // }

  Column _userTierName() {
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: _activeGameParticipantController.soloUserTier,
            builder: (context, value, _) {
              return Container(
                alignment: Alignment.center,
                width: 60,
                child: _activeGameParticipantController
                        .soloUserTier.value.tier.isNotEmpty
                    ? Text(
                        _activeGameParticipantController
                                .soloUserTier.value.tier +
                            " " +
                            _activeGameParticipantController
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
            valueListenable: _activeGameParticipantController.soloUserTier,
            builder: (context, value, _) {
              return Container(
                alignment: Alignment.center,
                width: 80,
                child: _activeGameParticipantController
                        .soloUserTier.value.tier.isNotEmpty
                    ? Text(
                        "(" +
                            _activeGameParticipantController
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

// _userTierSymbol() {
//   return ValueListenableBuilder(
//     valueListenable: _activeGameParticipantController.soloUserTier,
//     builder: (context, value, _) {
//       return Container(
//         child: _activeGameParticipantController
//                 .soloUserTier.value.tier.isNotEmpty
//             ? Image.asset(
//                 getUserTierImage(),
//                 width: 18,
//               )
//             : Container(
//                 margin: EdgeInsets.only(right: 10),
//                 child: Image.asset(
//                   imageUnranked,
//                   width: 17,
//                 ),
//               ),
//       );
//     },
//   );
// }

// String getUserTierImage() {
//   return _activeGameParticipantController.getUserTierImage(
//     _activeGameParticipantController.soloUserTier.value.tier,
//   );
// }
}

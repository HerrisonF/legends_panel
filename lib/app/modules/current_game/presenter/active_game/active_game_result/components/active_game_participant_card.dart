import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_result_repository/active_game_result_repository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/presenter/active_game/active_game_result/components/active_game_participant_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      activeGameResultRepository: GetIt.I<ActiveGameResultRepository>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.participant.teamId == BLUE_TEAM
            ? Colors.blue[800]
            : Color(0xFF7A1712),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      padding: EdgeInsets.only(top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      color: Colors.black,
                      margin: EdgeInsets.only(left: 5),
                      child: _summonerChampionBadge(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black,
                      ),
                      margin: EdgeInsets.only(right: 5),
                      child: Row(
                        children: [
                          _summonerSpells(),
                          _summonerPerks(),
                        ],
                      ),
                    ),
                    _summonerName(),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _userTierEmblem(),
                    Expanded(child: _userTierName()),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _summonerWinRate(),
              ),
            ],
          )
        ],
      ),
    );
  }

  _summonerChampionBadge() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(right: 2),
      child: Image.network(
        _activeGameParticipantController.generalController.getChampionBadgeUrl(
          widget.participant.championId,
        ),
      ),
    );
  }

  Column _summonerSpells() {
    return Column(
      children: [
        Container(
          height: 20,
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
          height: 20,
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 2),
            height: 18,
            child: Image.network(
              _activeGameParticipantController.generalController
                  .getPerkStyleBadgeUrl(
                perkId: widget.participant.perk!.perkStyle,
              ),
              errorBuilder: (context, error, stackTrace) {
                return SizedBox.shrink();
              },
            ),
          ),
          Container(
            height: 18,
            child: Image.network(
              _activeGameParticipantController.generalController
                  .getPerkStyleBadgeUrl(
                perkId: widget.participant.perk!.perkSubStyle,
              ),
              errorBuilder: (context, error, stackTrace) {
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _summonerName() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.participant.getSummonerName(),
        textAlign: TextAlign.start,
        maxLines: 2,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: widget.isToPaintUserName ? Colors.yellow : Colors.white,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _summonerWinRate() {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 5),
      child: Row(
        children: [
          Text(
            "${_activeGameParticipantController.getUserWinRate()}%",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          Text(
            " ( ${_activeGameParticipantController.getPlaySum()} ${AppLocalizations.of(context)!.played} )",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Container _userTierName() {
    return Container(
      child: Column(
        children: [
          Text(
            _activeGameParticipantController.getRankedSoloTierNameAndRank(),
            style: GoogleFonts.montserrat(
              fontSize: 10,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            _activeGameParticipantController.getRankedSoloLeaguePoints(),
            style: GoogleFonts.montserrat(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _userTierEmblem() {
    return Container(
      height: 30,
      child: Image.network(
        _activeGameParticipantController.getTierMiniEmblem(),
        errorBuilder: (context, error, stackTrace) {
          return Image.network(
            _activeGameParticipantController.getUnrankedEmblemUrl(),
          );
        },
      ),
    );
  }
}

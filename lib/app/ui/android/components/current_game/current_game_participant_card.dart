import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/data/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/data/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/ui/android/components/general/dots_loading.dart';

class CurrentGameParticipantCard extends StatefulWidget {
  final CurrentGameParticipant participant;
  final CurrentGameBannedChampion bannedChampion;

  CurrentGameParticipantCard(this.participant, this.bannedChampion);

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
    _currentGameParticipantController
        .getUserTier(widget.participant.summonerId);
    _currentGameParticipantController
        .getSpectator(widget.participant.summonerId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Image.network(
              _currentGameParticipantController.getChampionBadgeUrl(
                widget.participant.championId.toString(),
              ),
              width: 45,
              height: 80,
            ),
          ),
          Column(
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
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 65,
            child: Text(
              widget.participant.summonerName,
              style: TextStyle(fontSize: 13),
            ),
          ),
          Container(height: 10, child: VerticalDivider(color: Colors.black)),
          Container(
            width: 130,
            child: Row(
              children: [
                Obx(() {
                  return _currentGameParticipantController
                          .soloUserTier.value.tier.isNotEmpty
                      ? Image.network(
                          _currentGameParticipantController.getUserTierImage(
                              _currentGameParticipantController
                                  .soloUserTier.value.tier),
                          width: 28,
                          height: 28,
                        )
                      : DotsLoading();
                }),
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
                                style: TextStyle(fontSize: 12),
                              )
                            : DotsLoading(),
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
                                style: TextStyle(fontSize: 12),
                              )
                            : DotsLoading(),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
          Container(height: 10, child: VerticalDivider(color: Colors.black)),
          Obx(() {
            return _currentGameParticipantController
                    .soloUserTier.value.winRate.isNotEmpty
                ? Container(
                    child: Text(
                      _currentGameParticipantController
                              .soloUserTier.value.winRate +
                          "%",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                : DotsLoading();
          }),
          Container(height: 10, child: VerticalDivider(color: Colors.black)),
          Container(
            child: Container(
              child: widget.bannedChampion.championId > 0
                  ? Image.network(
                      _currentGameParticipantController.getChampionBadgeUrl(
                          widget.bannedChampion.championId.toString()),
                      width: 30,
                      height: 30,
                    )
                  : DotsLoading(),
            ),
          ),
        ],
      ),
    );
  }
}

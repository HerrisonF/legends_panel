import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/sub_controller/participant_controller/participant_controller.dart';
import 'package:legends_panel/app/data/model/spectator/banned_champion.dart';
import 'package:legends_panel/app/data/model/spectator/participant.dart';

class ParticipantCard extends StatefulWidget {
  final Participant participant;
  final BannedChampion bannedChampion;

  ParticipantCard(this.participant, this.bannedChampion);

  @override
  _ParticipantCardState createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard> {
  ParticipantController _participantController = ParticipantController();

  @override
  void initState() {
    super.initState();
    _participantController.getUserTier(widget.participant.summonerId);
    _participantController.getSpectator(widget.participant.summonerId);
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
              _participantController.getChampionBadgeUrl(
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
                  _participantController.getSpellUrl(
                    widget.participant.spell1Id.toString(),
                  ),
                  width: 22,
                  height: 22,
                ),
              ),
              Container(
                child: Image.network(
                  _participantController.getSpellUrl(
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
                  return _participantController
                          .soloUserTier.value.tier.isNotEmpty
                      ? Image.network(
                          _participantController.getUserTierImage(
                              _participantController.soloUserTier.value.tier),
                          width: 28,
                          height: 28,
                        )
                      : SizedBox.shrink();
                }),
                Column(
                  children: [
                    Obx(() {
                      return Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          _participantController.soloUserTier.value.tier +
                              " " +
                              _participantController.soloUserTier.value.rank,
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }),
                    Obx(() {
                      return Container(
                        child: Text(
                          "(" +
                              _participantController
                                  .soloUserTier.value.leaguePoints
                                  .toString() +
                              "LP)",
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
          Container(height: 10, child: VerticalDivider(color: Colors.black)),
          Obx(() {
            return _participantController.soloUserTier.value.winRate.isNotEmpty
                ? Container(
                    child: Text(
                      _participantController.soloUserTier.value.winRate + "%",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                : SizedBox.shrink();
          }),
          Container(height: 10, child: VerticalDivider(color: Colors.black)),
          Container(
            child: Container(
              child: widget.bannedChampion.championId > 0
                  ? Image.network(
                      _participantController.getChampionBadgeUrl(
                          widget.bannedChampion.championId.toString()),
                      width: 30,
                      height: 30,
                    )
                  : SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

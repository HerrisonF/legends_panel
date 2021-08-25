import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/sub_controller/game_detail_controller.dart';
import 'package:legends_panel/app/controller/sub_controller/participant_controller/participant_controller.dart';
import 'package:legends_panel/app/data/model/match_list.dart';

class GameCard extends StatefulWidget {
  final Match match;

  GameCard(this.match);

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  final GameDetailController _gameDetailController =
      GameDetailController();

  final ParticipantController _participantController =
      Get.put(ParticipantController());


  @override
  void initState() {
    _gameDetailController.getMatchDetail(widget.match.gameId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.greenAccent,
      child: Row(
        children: [
          Container(
            child: Image.network(
              _participantController.getChampionBadgeUrl(
                widget.match.champion.toString(),
              ),
              height: 50,
              width: 50,
            ),
          ),
          Column(
            children: [
              Container(
                child: Text(
                  widget.match.gameId.toString() + "--",
                ),
              ),
              Container(
                child: Text(
                  _gameDetailController.matchDetail.value.gameId
                      .toString(),
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                child: Text("PA"),
              ),
              Container(
                child: Text("PB"),
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Text("I1"),
                  ),
                  Container(
                    child: Text("I2"),
                  ),
                  Container(
                    child: Text("I3"),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text("I4"),
                  ),
                  Container(
                    child: Text("I5"),
                  )
                ],
              )
            ],
          ),
          Container(
            child: Text("Role"),
          ),
          Column(
            children: [
              Container(
                child: Text("Frag"),
              ),
              Container(
                child: Text("map Type"),
              ),
              Container(
                child: Text("time ago"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/result_controllers/profile_result_controller/profile_result_game_detail_controller.dart';
import 'package:legends_panel/app/data/model/general/match_list.dart';
import 'package:legends_panel/app/ui/android/components/general/dots_loading.dart';

class ItemMatchListGameCard extends StatefulWidget {
  final Match match;

  ItemMatchListGameCard(this.match);

  @override
  _ItemMatchListGameCardState createState() => _ItemMatchListGameCardState();
}

class _ItemMatchListGameCardState extends State<ItemMatchListGameCard> {
  final ProfileResultGameDetailController _profileResultGameDetailController =
      ProfileResultGameDetailController();

  @override
  void initState() {
    _profileResultGameDetailController
        .startProfileResultGame(widget.match.gameId.toString());
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
              _profileResultGameDetailController.getChampionBadgeUrl(
                widget.match.champion.toString(),
              ),
              height: 50,
              width: 50,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Container(
                  child: _profileResultGameDetailController
                              .participant.value.spell1d >
                          0
                      ? Image.network(
                          _profileResultGameDetailController.getSpellImage(1),
                          width: 25,
                          height: 25,
                        )
                      : DotsLoading(),
                );
              }),
              Obx(() {
                return Container(
                  child: _profileResultGameDetailController
                              .participant.value.spell2d >
                          0
                      ? Image.network(
                          _profileResultGameDetailController.getSpellImage(2),
                          width: 25,
                          height: 25,
                        )
                      : DotsLoading(),
                );
              })
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

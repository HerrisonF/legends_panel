import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/result_controllers/profile_result_controller/profile_result_game_detail_controller.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';

class ItemMatchListGameCard extends StatefulWidget {
  final MatchDetail matchDetail;

  ItemMatchListGameCard(this.matchDetail);

  @override
  _ItemMatchListGameCardState createState() => _ItemMatchListGameCardState();
}

class _ItemMatchListGameCardState extends State<ItemMatchListGameCard> {
  final ProfileResultGameDetailController _profileResultGameDetailController =
      ProfileResultGameDetailController();

  @override
  void initState() {
    _profileResultGameDetailController
        .startProfileResultGame(widget.matchDetail);
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
              _profileResultGameDetailController.getChampionBadgeUrl(),
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
                              .currentParticipant.value.summoner1Id >
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
                              .currentParticipant.value.summoner2Id >
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
              Row(
                children: [
                  Container(
                    child: Container(
                      child: _profileResultGameDetailController
                                  .currentParticipant.value.item0 >
                              0
                          ? Image.network(
                              _profileResultGameDetailController.getItemUrl(
                                  _profileResultGameDetailController
                                      .currentParticipant.value.item0
                                      .toString()),
                              width: 25,
                              height: 25,
                            )
                          : DotsLoading(),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: _profileResultGameDetailController
                                  .currentParticipant.value.item1 >
                              0
                          ? Image.network(
                              _profileResultGameDetailController.getItemUrl(
                                  _profileResultGameDetailController
                                      .currentParticipant.value.item1
                                      .toString()),
                              width: 25,
                              height: 25,
                            )
                          : DotsLoading(),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: _profileResultGameDetailController
                                  .currentParticipant.value.item2 >
                              0
                          ? Image.network(
                              _profileResultGameDetailController.getItemUrl(
                                  _profileResultGameDetailController
                                      .currentParticipant.value.item2
                                      .toString()),
                              width: 25,
                              height: 25,
                            )
                          : DotsLoading(),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: _profileResultGameDetailController
                                  .currentParticipant.value.item3 >
                              0
                          ? Image.network(
                              _profileResultGameDetailController.getItemUrl(
                                  _profileResultGameDetailController
                                      .currentParticipant.value.item3
                                      .toString()),
                              width: 25,
                              height: 25,
                            )
                          : DotsLoading(),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: _profileResultGameDetailController
                                  .currentParticipant.value.item4 >
                              0
                          ? Image.network(
                              _profileResultGameDetailController.getItemUrl(
                                  _profileResultGameDetailController
                                      .currentParticipant.value.item4
                                      .toString()),
                              width: 25,
                              height: 25,
                            )
                          : DotsLoading(),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: _profileResultGameDetailController
                                  .currentParticipant.value.item5 >
                              0
                          ? Image.network(
                              _profileResultGameDetailController.getItemUrl(
                                  _profileResultGameDetailController
                                      .currentParticipant.value.item5
                                      .toString()),
                              width: 25,
                              height: 25,
                            )
                          : DotsLoading(),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: _profileResultGameDetailController
                                  .currentParticipant.value.item6 >
                              0
                          ? Image.network(
                              _profileResultGameDetailController.getItemUrl(
                                  _profileResultGameDetailController
                                      .currentParticipant.value.item6
                                      .toString()),
                              width: 25,
                              height: 25,
                            )
                          : DotsLoading(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: Container(
              child: _profileResultGameDetailController
                          .currentParticipant.value.teamPosition != ""
                  ? Image.network(
                      _profileResultGameDetailController.getPositionUrl(
                          _profileResultGameDetailController
                              .currentParticipant.value.teamPosition),
                      width: 25,
                      height: 25,
                    )
                  : DotsLoading(),
            ),
          ),
          Column(
            children: [
              Container(
                child: Text("${_profileResultGameDetailController
                    .currentParticipant.value.kills}/${_profileResultGameDetailController
                    .currentParticipant.value.deaths}/${_profileResultGameDetailController
                    .currentParticipant.value.assists}"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

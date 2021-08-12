import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/sub_controller/profile_result_sub_controller/profile_result_sub_controller.dart';
import 'package:legends_panel/app/data/model/spectator/participant.dart';

class ProfileResultSubPage extends StatefulWidget {
  @override
  _ProfileResultSubPageState createState() => _ProfileResultSubPageState();
}

class _ProfileResultSubPageState extends State<ProfileResultSubPage> {
  final ProfileResultSubController _profileResultSubController =
      Get.find<ProfileResultSubController>();

  @override
  void initState() {
    _profileResultSubController.getMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.amber,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Text(_profileResultSubController.user.value.name),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx((){
                      return Container(
                        child: Text(_profileResultSubController.mapMode.value.mapName == "" ? "Loading" : _profileResultSubController.mapMode.value.mapName),
                      );
                    }),
                    Container(
                      child: Text(
                          _profileResultSubController.spectator.value.gameMode),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    "${_profileResultSubController.minutes()} min",
                  ),
                ),
                _detachTeams(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _detachTeams() {
    return Column(
      children: [
        Obx(() {
          return _teamCard(_profileResultSubController.blueTeam);
        }),
        Container(
          height: 30,
          color: Colors.greenAccent,
        ),
        Obx(() {
          return _teamCard(_profileResultSubController.redTeam);
        }),
      ],
    );
  }

  _teamCard(RxList<Participant> team) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: team.length,
      itemBuilder: (_, index) {
        return _participantCard(team[index]);
      },
    );
  }

  _participantCard(Participant participant) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              child: Image.network(
                _profileResultSubController.getChampionBadgeUrl(
                  participant.championId.toString(),
                ),
                width: 30,
                height: 30,
              ),
            ),
            Column(
              children: [
                Container(
                  child: Image.network(
                    _profileResultSubController.getSpellUrl(
                      participant.spell1Id.toString(),
                    ),
                    width: 30,
                    height: 30,
                  ),
                ),
                Container(
                  child: Image.network(
                    _profileResultSubController.getSpellUrl(
                      participant.spell2Id.toString(),
                    ),
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            Text(participant.summonerName),
            Container(height: 10, child: VerticalDivider(color: Colors.black)),
            Row(
              children: [
                Container(
                  child: Text("elo"),
                ),
                Column(
                  children: [
                    Container(
                      child: Text("Elo 2"),
                    ),
                    Container(
                      child: Text("PDL"),
                    ),
                  ],
                )
              ],
            ),
            Container(height: 10, child: VerticalDivider(color: Colors.black)),
            Container(
              child: Text("V%"),
            ),
            Container(height: 10, child: VerticalDivider(color: Colors.black)),
            Container(
              child: Text("B champ"),
            ),
          ],
        )
      ],
    );
  }
}

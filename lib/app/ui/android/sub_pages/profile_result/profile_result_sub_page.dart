import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/sub_controller/profile_result_sub_controller/profile_result_sub_controller.dart';
import 'package:legends_panel/app/data/model/spectator/banned_champion.dart';
import 'package:legends_panel/app/data/model/spectator/participant.dart';
import 'package:legends_panel/app/ui/android/components/participant_card.dart';

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
                    Obx(() {
                      return Container(
                        child: Text(
                            _profileResultSubController.mapMode.value.mapName ==
                                    ""
                                ? "Loading"
                                : _profileResultSubController
                                    .mapMode.value.mapName),
                      );
                    }),
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
          return _teamCard(_profileResultSubController.blueTeam, _profileResultSubController.blueTeamBannedChamp);
        }),
        Container(
          height: 30,
          color: Colors.greenAccent,
        ),
        Obx(() {
          return _teamCard(_profileResultSubController.redTeam, _profileResultSubController.redTeamBannedChamp);
        }),
      ],
    );
  }

  _teamCard(RxList<Participant> participants, RxList<BannedChampion> bannedChampions) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: participants.length,
      itemBuilder: (_, index) {
        return ParticipantCard(participants[index], bannedChampions[index]);
      },
    );
  }
}

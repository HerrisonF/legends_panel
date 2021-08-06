import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/sub_controller/profile_result_sub_page/profile_result_sub_controller.dart';
import 'package:legends_panel/app/data/model/spectator/participant.dart';

class ProfileResultSubPage extends StatelessWidget {

  final ProfileResultSubController _profileResultSubController =
      Get.find<ProfileResultSubController>();

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
                Obx(() {
                  return _detachTeams();
                }),
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
        Container(),
        Obx(() {
          return _teamCard(_profileResultSubController.redTeam);
        }),
      ],
    );
  }

  _teamCard(RxList<Participant> team) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: team.length,
      itemBuilder: (_, index) {
        return Column(
          children: [
            Container(
              child: Text(
                team[index].teamId.toString(),
              ),
            ),
            Container(
              child: Text(
                team[index].summonerName,
              ),
            )
          ],
        );
      },
    );
  }
}

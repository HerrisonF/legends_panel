import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';

class AboutPage extends StatelessWidget {
  final MasterController _masterController = Get.find<MasterController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            return _masterController.userProfile.value.name != ""
                ? Container(
                    child: Container(
                      height: 100,
                      color: Colors.blue,
                      child: IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          goToProfile();
                        },
                      ),
                    ),
                  )
                : SizedBox.shrink();
          }),
          Container(child: Text("1.0")),
          Container(
              child: Text(
                  "© 2021 WatchSummoner isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.")),
          Container(child: Text("Desenvolvido por: Herrison Féres")),
        ],
      ),
    );
  }

  goToProfile() {
    final ProfileController _profileController = Get.find<ProfileController>();
    _profileController.deletePersistedUser();
    _masterController.changeCurrentPageIndex(0);
  }
}
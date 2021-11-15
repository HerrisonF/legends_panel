import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';

class MasteryChampions extends StatelessWidget {
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return _profileController.championMasteryList.length > 0
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _championBadge(1, false, context),
                    _championBadge(0, true, context),
                    _championBadge(2, false, context),
                  ],
                ),
              )
            : DotsLoading();
      },
    );
  }


  static const int NEXUS_ONE_SCREEN = 800;

  Container _championBadge(int index, bool best, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal:  MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? 35 : 31,
        vertical: best ? 0 : 10,
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? MediaQuery.of(context).size.width/6 : MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? MediaQuery.of(context).size.height / 13 : MediaQuery.of(context).size.height / 12,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  _profileController.getCircularChampionImage(
                      _profileController.championMasteryList[index].championId),
                ),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? MediaQuery.of(context).size.height / 20 : MediaQuery.of(context).size.height / 18,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height/20,
              child: Image.network(
                _profileController.getMasteryImage(index),
              ),
            ),
          )
        ],
      ),
    );
  }
}

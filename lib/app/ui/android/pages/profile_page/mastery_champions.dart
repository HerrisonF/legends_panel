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
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _championBadge(1, false),
                    _championBadge(0, true),
                    _championBadge(2, false),
                  ],
                ),
              )
            : DotsLoading();
      },
    );
  }

  Container _championBadge(int index, bool best) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: best ? 0 : 25),
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
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
            top: 60,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
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

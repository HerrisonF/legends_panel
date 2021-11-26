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
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _championBadge(1, context),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: _championBadge(0, context),
                  ),
                  _championBadge(2, context),
                ],
              )
            : DotsLoading();
      },
    );
  }

  _championBadge(int index, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 23, vertical: 12),
          width: MediaQuery.of(context).size.height > 800 ? 60 : 40,
          height: MediaQuery.of(context).size.height > 800 ? 60 : 40,
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
          bottom: MediaQuery.of(context).size.height > 800 ? -3 : 3,
          child: Container(
            height: MediaQuery.of(context).size.height > 800 ? 30 : 20,
            child: Image.network(
              _profileController.getMasteryImage(index),
            ),
          ),
        )
      ],
    );
  }
}

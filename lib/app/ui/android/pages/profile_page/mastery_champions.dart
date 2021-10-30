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
                color: Colors.green,
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(left: 28),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            _profileController.getChampionImage(_profileController.championMasteryList[index].championId),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height / 7,
                            left: MediaQuery.of(context).size.width / 13,
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Image.network(_profileController.getMasteryImage(index)),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            : DotsLoading();
      },
    );
  }
}

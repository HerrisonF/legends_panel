import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/core/utils/screen_utils.dart';
import 'package:legends_panel/app/ui/android/components/dots_loading.dart';

class MasteryChampions extends StatelessWidget {
  final ProfileController _profileController = GetIt.I<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _profileController.championMasteryList,
      builder:
      (context, value, _) {
        return _profileController.championMasteryList.value.length > 0
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
        _profileController
                .getCircularChampionImage(
                    _profileController.championMasteryList.value[index].championId)
                .isNotEmpty
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                width: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 55 : 40,
                height: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 55 : 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      _profileController.getCircularChampionImage(
                          _profileController
                              .championMasteryList.value[index].championId),
                    ),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              )
            : SizedBox.shrink(),
        Positioned(
          bottom: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 0 : 4,
          child: Container(
            height: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 25 : 20,
            child: Image.network(
              _profileController.getMasteryImage(index),
            ),
          ),
        )
      ],
    );
  }
}

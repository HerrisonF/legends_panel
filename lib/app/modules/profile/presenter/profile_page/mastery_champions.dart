import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_controller/profile_controller.dart';

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
            : CircularProgressIndicator();
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
                width: 40,
                height: 40,
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
          bottom: 0,
          child: Container(
            height: 25,
            child: Image.network(
              _profileController.getMasteryImage(index),
            ),
          ),
        )
      ],
    );
  }
}

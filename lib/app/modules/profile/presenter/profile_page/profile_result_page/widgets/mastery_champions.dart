import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/profile/domain/models/champion_mastery_model.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/profile_result_page/profile_result_page_controller.dart';

class MasteryChampions extends StatelessWidget {
  final ProfileResultController profileResultController;

  MasteryChampions({
    required this.profileResultController,
  });

  @override
  Widget build(BuildContext context) {
    return profileResultController.summonerProfileModel!.masteries != null &&
            profileResultController.summonerProfileModel!.masteries!.length > 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: profileResultController.summonerProfileModel!.masteries!
                .map(
                  (e) => _championBadge(e),
                )
                .toList(),
          )
        : SizedBox.shrink();
  }

  Container _championBadge(ChampionMasteryModel championMastery) {
    return Container(
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          profileResultController.generalController
              .getChampionBadgeUrl(championMastery.championId)
              .isNotEmpty
              ? Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  profileResultController.generalController
                      .getChampionBadgeUrl(championMastery.championId),
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
              height: 30,
              child: Image.network(
                profileResultController.profileRepository.getMasteryImage(
                  championLevel: championMastery.championLevel.toString(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

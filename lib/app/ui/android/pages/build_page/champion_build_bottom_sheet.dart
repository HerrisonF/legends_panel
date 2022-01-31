import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/champion_build_bottom_sheet_controller/champion_build_bottom_sheet_controller.dart';

class ChampionBuildBottomSheet extends StatefulWidget {
  final String championId;

  ChampionBuildBottomSheet({Key? key, this.championId = ""}) : super(key: key);

  @override
  State<ChampionBuildBottomSheet> createState() =>
      _ChampionBuildBottomSheetState();
}

class _ChampionBuildBottomSheetState extends State<ChampionBuildBottomSheet> {
  final ChampionBuildBottomSheetController _championBuildBottomSheetController =
      Get.put(ChampionBuildBottomSheetController());

  @override
  void initState() {
    _championBuildBottomSheetController.init(widget.championId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return _championBuildBottomSheetController.isLoading.value
            ? CircularProgressIndicator()
            : _championStats();
      },
    );
  }

  _championStats() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: _championSkills(),
        ),
      ],
    );
  }

  _championSkills() {
    return Column(
      children: [
        _championSkillTitle(),
        _championSkillOneToNine(),
        _championSkillTenToEighteen(9),
        _championPerksTitle(),
        _championPerks(),
      ],
    );
  }

  _championPerks(){
    return Column(
      children: [
        Row(
            children: [
              _roundedContainer(""),
            ],
        ),
        Row(
          children: [
            _roundedContainer(""),
          ],
        ),
      ],
    );
  }

  _roundedContainer(String image){
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.green,
      ),
      child: Container(),
    );
  }

  _championPerksTitle(){
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Text("Perks"),
    );
  }

  _championSkillTitle(){
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Text("Ability order"),
    );
  }

  _championSkillOneToNine() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: ListView.builder(
        itemCount: 9,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 25,
            width: 28,
            margin: EdgeInsets.only(
              left: 14,
            ),
            child: Obx(() {
              return !_championBuildBottomSheetController
                      .isLoadingChampion.value
                  ? Column(
                      children: [
                        Text(
                          (index + 1).toString(),
                        ),
                        Container(
                          //margin: EdgeInsets.only(top: 5),
                          child: Text(
                            _championBuildBottomSheetController.getSpellKey(
                              _championBuildBottomSheetController
                                  .dataAnalysisModel
                                  .statisticOnPosition
                                  .statisticSkill
                                  .skillsOrder[index]
                                  .skillSlot,
                            ),
                          ),
                        ),
                        Container(
                          child: Image.network(
                            _championBuildBottomSheetController
                                .getChampionSpell(
                              widget.championId,
                              _championBuildBottomSheetController
                                  .dataAnalysisModel
                                  .statisticOnPosition
                                  .statisticSkill
                                  .skillsOrder[index]
                                  .skillSlot,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator();
            }),
          );
        },
      ),
    );
  }

  _championSkillTenToEighteen(int continueIndex) {
    return Container(
      height: 80,
      child: ListView.builder(
        itemCount: 9,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 25,
            width: 28,
            margin: EdgeInsets.only(
              left: 14,
            ),
            child: Obx(() {
              return !_championBuildBottomSheetController
                      .isLoadingChampion.value
                  ? Column(
                      children: [
                        Text(
                          (index + continueIndex + 1).toString(),
                        ),
                        Container(
                          //margin: EdgeInsets.only(top: 5),
                          child: Text(
                            _championBuildBottomSheetController.getSpellKey(
                              _championBuildBottomSheetController
                                  .dataAnalysisModel
                                  .statisticOnPosition
                                  .statisticSkill
                                  .skillsOrder[index + continueIndex]
                                  .skillSlot,
                            ),
                          ),
                        ),
                        Container(
                          child: Image.network(
                            _championBuildBottomSheetController
                                .getChampionSpell(
                              widget.championId,
                              _championBuildBottomSheetController
                                  .dataAnalysisModel
                                  .statisticOnPosition
                                  .statisticSkill
                                  .skillsOrder[index + continueIndex]
                                  .skillSlot,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator();
            }),
          );
        },
      ),
    );
  }
}

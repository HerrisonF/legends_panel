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
            : Container(
                child: Center(
                  child: Text(
                      "Chmapion Build ${_championBuildBottomSheetController.dataAnalysisModel.statisticOnPosition.statisticSkill.skillsOrder.map((e) => e.skillSlot.toString()).toList()}"),
                ),
              );
      },
    );
  }
}

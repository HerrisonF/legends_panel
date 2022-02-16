import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/champion_build_bottom_sheet_controller/champion_build_bottom_sheet_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            ? Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 170, vertical: 10),
                child: CircularProgressIndicator(),
              )
            : _championBuildBottomSheetController
                        .championStatistic.positions.length >
                    0
                ? _championStats()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(AppLocalizations.of(context)!.noBuildChampion),
                  );
      },
    );
  }

  _championStats() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: _championBuildBottomSheetController.mostPositions.length == 1
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        itemExtent: MediaQuery.of(context).size.width,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: _championSkills(0),
          ),
          _championBuildBottomSheetController.mostPositions.length > 1
              ? Container(
                  margin: EdgeInsets.only(top: 20),
                  child: _championSkills(1),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  _championSkills(int positionIndex) {
    return Column(
      children: [
        _BETA(),
        _positionTitle(positionIndex),
        _championSkillTitle(),
        _championSkill(positionIndex),
        _championPerksTitle(),
        _championPerks(positionIndex),
        _championItemTitle(),
        _championItems(positionIndex),
        _championSpellTitle(),
        _championSpells(positionIndex),
      ],
    );
  }

  _BETA() {
    return Container(
      child: Text(
        "BETA",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _positionTitle(int positionIndex) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        _championBuildBottomSheetController
            .championStatistic.positions[positionIndex].role.capitalizeFirst!,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  _championSpellTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(AppLocalizations.of(context)!.spell),
    );
  }

  _championSpells(int positionIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 5),
          child: Image.network(
            _championBuildBottomSheetController.getSpellUrl(
                _championBuildBottomSheetController
                    .championStatistic
                    .positions[positionIndex]
                    .builds[0]
                    .selectedSpell
                    .spell
                    .spellId1
                    .toString()),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 5),
          child: Image.network(
            _championBuildBottomSheetController.getSpellUrl(
                _championBuildBottomSheetController
                    .championStatistic
                    .positions[positionIndex]
                    .builds[0]
                    .selectedSpell
                    .spell
                    .spellId2
                    .toString()),
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  _championItemTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text("Build"),
    );
  }

  _championItems(int positionIndex) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(bottom: 60),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        spacing: 5,
        runSpacing: 16,
        children: _championBuildBottomSheetController
            .championStatistic
            .positions[positionIndex]
            .builds[0]
            .selectedBuild
            .selectedItems
            .items.map((e) {
              int index = _championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedBuild
                  .selectedItems
                  .items.indexOf(e);
              return Container(
                height: 35,
                child: Image.network(
                  _championBuildBottomSheetController.getItemUrl(
                      _championBuildBottomSheetController
                          .championStatistic
                          .positions[positionIndex]
                          .builds[0]
                          .selectedBuild
                          .selectedItems
                          .items[index]
                          .id
                          .toString()),
                  fit: BoxFit.cover,
                ),
              );
        }).toList(),
      ),
    );
  }

  _championPerks(int positionIndex) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            children: [
              _roundedStyleContainer(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .styles[0]
                  .style
                  .toString()),
              _roundedPerkContainer(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .styles[0]
                  .selections[0]
                  .perk
                  .toString()),
              _roundedPerkContainer(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .styles[0]
                  .selections[1]
                  .perk
                  .toString()),
              _roundedPerkContainer(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .styles[0]
                  .selections[2]
                  .perk
                  .toString()),
              _roundedPerkContainer(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .styles[0]
                  .selections[3]
                  .perk
                  .toString()),
            ],
          ),
          Row(
            children: [
              _roundedStyleContainer(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .styles[1]
                  .style
                  .toString()),
              _roundedPerkContainer(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .styles[1]
                  .selections[0]
                  .perk
                  .toString()),
              _roundedPerkContainer(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .styles[1]
                  .selections[1]
                  .perk
                  .toString()),
              _roundedPerkShard(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .statPerks
                  .offense
                  .toString()),
              _roundedPerkShard(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .statPerks
                  .flex
                  .toString()),
              _roundedPerkShard(_championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedRune
                  .perk
                  .statPerks
                  .defense
                  .toString()),
            ],
          ),
        ],
      ),
    );
  }

  _roundedStyleContainer(String image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: NetworkImage(
            _championBuildBottomSheetController.getPerkStyleUrl(image),
          ),
        ),
      ),
    );
  }

  _roundedPerkShard(String image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: NetworkImage(
            _championBuildBottomSheetController.getPerkShard(image),
          ),
        ),
      ),
    );
  }

  _roundedPerkContainer(String image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: NetworkImage(
            _championBuildBottomSheetController.getPerk(image),
          ),
        ),
      ),
    );
  }

  _championPerksTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(AppLocalizations.of(context)!.perk),
    );
  }

  _championSkillTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        AppLocalizations.of(context)!.abilityOrder,
      ),
    );
  }

  _championSkill(int positionIndex) {
    return Container(
      margin: EdgeInsets.only(left: 15, bottom: 60),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Wrap(
        spacing: 5,
        runSpacing: 16,
        children: _championBuildBottomSheetController.championStatistic
            .positions[positionIndex].builds[0].selectedSkill.skillsOrder
            .map((e) {
          return Obx(() {
            int index = _championBuildBottomSheetController.championStatistic
                .positions[positionIndex].builds[0].selectedSkill.skillsOrder
                .indexOf(e);
            return !_championBuildBottomSheetController.isLoadingChampion.value
                ? Column(
                    children: [
                      Text(
                        (_championBuildBottomSheetController
                                    .championStatistic
                                    .positions[positionIndex]
                                    .builds[0]
                                    .selectedSkill
                                    .skillsOrder
                                    .indexOf(e) +
                                1)
                            .toString(),
                      ),
                      Container(
                        //margin: EdgeInsets.only(top: 5),
                        child: Text(
                          _championBuildBottomSheetController.getSpellKey(
                            _championBuildBottomSheetController
                                .championStatistic
                                .positions[positionIndex]
                                .builds[0]
                                .selectedSkill
                                .skillsOrder[index]
                                .skillSlot,
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        child: Image.network(
                          _championBuildBottomSheetController.getChampionSpell(
                            widget.championId,
                            _championBuildBottomSheetController
                                .championStatistic
                                .positions[positionIndex]
                                .builds[0]
                                .selectedSkill
                                .skillsOrder[index]
                                .skillSlot,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                : CircularProgressIndicator();
          });
        }).toList(),
      ),
    );
  }
}

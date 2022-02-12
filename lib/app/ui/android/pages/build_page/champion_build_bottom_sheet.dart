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
        physics:
            // _championBuildBottomSheetController
            //             .championStatistic.positions.length ==
            //         1
            //     ?
            NeverScrollableScrollPhysics(),
        //: AlwaysScrollableScrollPhysics(),
        itemExtent: MediaQuery.of(context).size.width,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: _championSkills(0),
          ),
          // _championBuildBottomSheetController
          //             .championStatistic.positions.length >
          //         1
          //     ? Container(
          //         margin: EdgeInsets.only(top: 20),
          //         child: _championSkills(1),
          //       )
          //     : SizedBox.shrink(),
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
        _championSkillOneToNine(positionIndex),
        _championSkillTenToEighteen(9, positionIndex),
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
            .championStatistic.positions[positionIndex].name.capitalizeFirst!,
        style: TextStyle(
          fontSize: 15,
        ),
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
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: _championBuildBottomSheetController
            .championStatistic
            .positions[positionIndex]
            .builds[0]
            .selectedBuild
            .selectedItems
            .items
            .length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: 5),
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
        },
      ),
    );
  }

  _championPerks(int positionIndex) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          //Container(child: Text("domination"),),
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
          //Container(child: Text("precision"),),
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

  _championSkillOneToNine(int positionIndex) {
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
                          child: Image.network(
                            _championBuildBottomSheetController
                                .getChampionSpell(
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
            }),
          );
        },
      ),
    );
  }

  _championSkillTenToEighteen(int continueIndex, int positionIndex) {
    return Container(
      height: 80,
      child: ListView.builder(
        itemCount: _championBuildBottomSheetController
                    .championStatistic
                    .positions[positionIndex]
                    .builds[0]
                    .selectedSkill
                    .skillsOrder
                    .length >
                18
            ? 9
            : 8,
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
                                  .championStatistic
                                  .positions[positionIndex]
                                  .builds[0]
                                  .selectedSkill
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
                                  .championStatistic
                                  .positions[positionIndex]
                                  .builds[0]
                                  .selectedSkill
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

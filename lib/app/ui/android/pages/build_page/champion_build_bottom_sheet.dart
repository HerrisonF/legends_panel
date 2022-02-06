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
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView(
       scrollDirection: Axis.horizontal,
        physics: _championBuildBottomSheetController.championStatistic.positions.length == 1 ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
        itemExtent: MediaQuery.of(context).size.width,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: _championSkills(0),
          ),
          _championBuildBottomSheetController.championStatistic.positions.length > 1 ? Container(
            margin: EdgeInsets.only(top: 20),
            child: _championSkills(1),
          ) : SizedBox.shrink(),
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

  _BETA(){
    return Container(
      child: Text("BETA"),
    );
  }

  _positionTitle(int positionIndex){
    return Container(
      child: Text(_championBuildBottomSheetController.championStatistic.positions[positionIndex].name),
    );
  }

  _championSpellTitle(){
    return Container(
      child: Text("Spell"),
    );
  }

  _championSpells(int positionIndex){
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Image.network(
            _championBuildBottomSheetController.getSpellUrl(
                _championBuildBottomSheetController.championStatistic.positions[positionIndex].builds[positionIndex].selectedSpell.spell.spellId1.toString()),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Image.network(
            _championBuildBottomSheetController.getSpellUrl(
                _championBuildBottomSheetController.championStatistic.positions[positionIndex].builds[positionIndex].selectedSpell.spell.spellId2
                    .toString()),
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  _championItemTitle() {
    return Container(
      child: Text("Items"),
    );
  }

  _championItems(int positionIndex) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: _championBuildBottomSheetController.championStatistic.positions[positionIndex].builds[positionIndex].selectedBuild.selectedItems.items.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: 5),
            child: Image.network(
              _championBuildBottomSheetController.getItemUrl(
                  _championBuildBottomSheetController
                      .championStatistic.positions[positionIndex]
                      .builds[positionIndex].selectedBuild
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
    return Column(
      children: [
        //Container(child: Text("domination"),),
        Row(
          children: [
            _roundedStyleContainer(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .styles[0]
                .style
                .toString()),
            _roundedPerkContainer(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .styles[0]
                .selections[0]
                .perk
                .toString()),
            _roundedPerkContainer(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .styles[0]
                .selections[1]
                .perk
                .toString()),
            _roundedPerkContainer(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .styles[0]
                .selections[2]
                .perk
                .toString()),
            _roundedPerkContainer(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
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
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .styles[1]
                .style
                .toString()),
            _roundedPerkContainer(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune.perk
                .styles[1]
                .selections[0]
                .perk
                .toString()),
            _roundedPerkContainer(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .styles[1]
                .selections[1]
                .perk
                .toString()),
            _roundedPerkShard(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .statPerks
                .offense
                .toString()),
            _roundedPerkShard(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .statPerks
                .flex
                .toString()),
            _roundedPerkShard(_championBuildBottomSheetController
                .championStatistic.positions[positionIndex].builds[positionIndex].selectedRune
                .perk
                .statPerks
                .defense
                .toString()),
          ],
        ),
      ],
    );
  }

  _roundedStyleContainer(String image) {
    return Container(
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
      margin: EdgeInsets.only(bottom: 15),
      child: Text("Perks"),
    );
  }

  _championSkillTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Text("Ability order"),
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
                                  .championStatistic.positions[positionIndex].builds[positionIndex].selectedSkill.
                                  skillsOrder[index]
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
                                  .championStatistic.positions[positionIndex].builds[positionIndex].selectedSkill.
                                  skillsOrder[index]
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
                                  .championStatistic.positions[positionIndex].builds[positionIndex].selectedSkill
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
                                  .championStatistic.positions[positionIndex].builds[positionIndex].selectedSkill
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

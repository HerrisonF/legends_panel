import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/champion_build_bottom_sheet_controller/champion_build_bottom_sheet_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChampionBuildBottomSheet extends StatefulWidget {
  final String championId;
  final String championName;

  ChampionBuildBottomSheet(
      {Key? key, this.championId = "", this.championName = ""})
      : super(key: key);

  @override
  State<ChampionBuildBottomSheet> createState() =>
      _ChampionBuildBottomSheetState();
}

class _ChampionBuildBottomSheetState extends State<ChampionBuildBottomSheet>
    with SingleTickerProviderStateMixin {
  final ChampionBuildBottomSheetController _championBuildBottomSheetController =
      Get.put(ChampionBuildBottomSheetController());

  late Timer _timer;
  int _start = 1;

  @override
  void initState() {
    _championBuildBottomSheetController.init(widget.championId);
    super.initState();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            _visible = !_visible;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: [
            _championBuildBottomSheetController.isLoading.value
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child:
                            Text(AppLocalizations.of(context)!.noBuildChampion),
                      ),
            _animatedIndicator(),
          ],
        );
      },
    );
  }

  _championStats() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
      ),
      child: Container(
        color: Colors.grey[200],
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
      ),
    );
  }

  _championSkills(int positionIndex) {
    return ListView(
      children: [
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

  _animatedIndicator() {
    return _championBuildBottomSheetController.mostPositions.length > 1
        ? _animatedArrow()
        : SizedBox.shrink();
  }

  bool _visible = true;

  _animatedArrow() {
    return Positioned(
      top: MediaQuery.of(context).size.height / 4.5,
      right: 0,
      child: AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: _visible ? 1.0 : 0.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8), bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
            color: Colors.blue[100],
          ),
          height: MediaQuery.of(context).size.height / 2,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 5,
          ),
        ),
      ),
    );
  }

  _imageDivider() {
    return Container(
      height: 20,
      //width: MediaQuery.of(context).size.width,
      child: Image.asset(imageDivider),
    );
  }

  _positionTitle(int positionIndex) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "${widget.championName + " - " + _championBuildBottomSheetController.championStatistic.positions[positionIndex].role.capitalizeFirst!}",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  _championSpellTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        AppLocalizations.of(context)!.spell,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _championSpells(int positionIndex) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.indigo,
              width: 1,
            )),
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
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.indigo,
              width: 1,
            )),
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
      ),
    );
  }

  _championItemTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        AppLocalizations.of(context)!.buildSuggestion,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _championItems(int positionIndex) {
    return Column(
      children: [
        Container(
          height: 35,
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
                .items
                .map((e) {
              int index = _championBuildBottomSheetController
                  .championStatistic
                  .positions[positionIndex]
                  .builds[0]
                  .selectedBuild
                  .selectedItems
                  .items
                  .indexOf(e);
              return Container(
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 1,
                )),
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
                  fit: BoxFit.scaleDown,
                ),
              );
            }).toList(),
          ),
        ),
        _imageDivider(),
      ],
    );
  }

  _championPerks(int positionIndex) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
            mainAxisAlignment: MainAxisAlignment.center,
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
          _imageDivider(),
        ],
      ),
    );
  }

  _roundedStyleContainer(String image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          fit: BoxFit.scaleDown,
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
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          fit: BoxFit.scaleDown,
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
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          fit: BoxFit.scaleDown,
          image: NetworkImage(
            _championBuildBottomSheetController.getPerk(image),
          ),
        ),
      ),
    );
  }

  _championPerksTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        AppLocalizations.of(context)!.perk,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _championSkillTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        AppLocalizations.of(context)!.abilityOrder,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _championSkill(int positionIndex) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, bottom: 100),
          width: MediaQuery.of(context).size.width,
          height: 65,
          child: Wrap(
            spacing: 5,
            runSpacing: 16,
            children: _championBuildBottomSheetController.championStatistic
                .positions[positionIndex].builds[0].selectedSkill.skillsOrder
                .map((e) {
              return Obx(() {
                int index = _championBuildBottomSheetController
                    .championStatistic
                    .positions[positionIndex]
                    .builds[0]
                    .selectedSkill
                    .skillsOrder
                    .indexOf(e);
                return !_championBuildBottomSheetController
                        .isLoadingChampion.value
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
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: Colors.indigo),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
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
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.lightBlue,
                              width: 2,
                            )),
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
              });
            }).toList(),
          ),
        ),
        _imageDivider(),
      ],
    );
  }
}

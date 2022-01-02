import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_result_game_detail_controller.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'general_vision/general_vision_component.dart';

class ItemMatchListGameCard extends StatefulWidget {
  final MatchDetail matchDetail;

  ItemMatchListGameCard(this.matchDetail);

  @override
  _ItemMatchListGameCardState createState() => _ItemMatchListGameCardState();
}

class _ItemMatchListGameCardState extends State<ItemMatchListGameCard> {
  final ProfileResultGameDetailController _profileResultGameDetailController =
      ProfileResultGameDetailController();
  final MasterController _masterController = Get.find<MasterController>();

  @override
  void initState() {
    _profileResultGameDetailController
        .startProfileResultGame(widget.matchDetail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModalGeneralVision();
      },
      child: Container(
        height:
            _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 75 : 60,
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        margin: EdgeInsets.symmetric(vertical: 2),
        color: _profileResultGameDetailController.currentParticipant.value.win
            ? Colors.blue.withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _championBadge(context),
                Row(
                  children: [
                    _itemBase(
                      item: _profileResultGameDetailController
                          .currentParticipant.value.item0,
                    ),
                    _itemBase(
                      item: _profileResultGameDetailController
                          .currentParticipant.value.item1,
                    ),
                    _itemBase(
                      item: _profileResultGameDetailController
                          .currentParticipant.value.item2,
                    ),
                    _itemBase(
                      item: _profileResultGameDetailController
                          .currentParticipant.value.item3,
                    ),
                    _itemBase(
                      item: _profileResultGameDetailController
                          .currentParticipant.value.item4,
                    ),
                    _itemBase(
                      item: _profileResultGameDetailController
                          .currentParticipant.value.item5,
                    ),
                    _itemBase(
                      item: _profileResultGameDetailController
                          .currentParticipant.value.item6,
                      last: true,
                    ),
                  ],
                ),
                _userPosition(),
              ],
            ),
            _userKDA(),
          ],
        ),
      ),
    );
  }

  _showModalGeneralVision() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return GeneralVisionComponent(
          matchDetail: widget.matchDetail,
          participant:
              _profileResultGameDetailController.currentParticipant.value,
          primaryStylePerk: _profileResultGameDetailController.getSpellImage(1),
          subStylePerk: _profileResultGameDetailController.getSpellImage(2),
        );
      },
    );
  }

  _userKDA() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              _profileResultGameDetailController.currentParticipant.value.win
                  ? "${AppLocalizations.of(context)!.gameVictory}"
                  : "${AppLocalizations.of(context)!.gameDefeat}",
              style: GoogleFonts.montserrat(
                color: Colors.yellow,
                fontWeight: FontWeight.w400,
                fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                    ? 13
                    : 9,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "${_profileResultGameDetailController.currentParticipant.value.kills} / ${_profileResultGameDetailController.currentParticipant.value.deaths} / ${_profileResultGameDetailController.currentParticipant.value.assists}",
              style: GoogleFonts.montserrat(
                color: Colors.yellow,
                fontWeight: FontWeight.w400,
                fontSize: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                    ? 12
                    : 8,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Container _userPosition() {
    return Container(
      height: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 25 : 20,
      width: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 25 : 20,
      margin: EdgeInsets.only(left:  _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 5 : 0),
      child: _profileResultGameDetailController
                  .currentParticipant.value.teamPosition !=
              ""
          ? Image.network(
              _profileResultGameDetailController.getPositionUrl(
                _profileResultGameDetailController
                    .currentParticipant.value.teamPosition,
              ),
              width: MediaQuery.of(context).size.width / 16,
            )
          : Image.asset(
              imageIconItemNone,
              width: MediaQuery.of(context).size.width / 16,
            ),
    );
  }

  _itemBase({required dynamic item, bool last = false}) {
    return Container(
      height: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 33 : 25,
      width: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 33 : 25,
      margin: EdgeInsets.only(left: last ? 10 : 0),
      child: Container(
        child: item > 0
            ? Image.network(
                _profileResultGameDetailController.getItemUrl(item.toString()),
                width: MediaQuery.of(context).size.width / 16,
                fit: BoxFit.cover,
              )
            : Image.asset(
                imageIconItemNone,
                width: MediaQuery.of(context).size.width / 16,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  _spellImage2(BuildContext context) {
    return Container(
      height: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 24 : 16,
      width: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 24 : 16,
      margin: EdgeInsets.only(right: 5),
      child: _profileResultGameDetailController
                  .currentParticipant.value.summoner2Id !=
              ""
          ? Image.network(
              _profileResultGameDetailController.getSpellImage(2),
              width: MediaQuery.of(context).size.width / 20,
            )
          : Image.network(
              imageIconItemNone,
              width: MediaQuery.of(context).size.width / 20,
            ),
    );
  }

  _spellImage1(BuildContext context) {
    return Container(
      height: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 24 : 16,
      width: _masterController.screenWidthSizeIsBiggerThanNexusOne() ? 24 : 16,
      margin: EdgeInsets.only(right: 5),
      child: _profileResultGameDetailController
                  .currentParticipant.value.summoner1Id !=
              ""
          ? Image.network(
              _profileResultGameDetailController.getSpellImage(1),
              width: MediaQuery.of(context).size.width / 20,
            )
          : Image.asset(
              imageIconItemNone,
              width: MediaQuery.of(context).size.width / 20,
            ),
    );
  }

  Widget _championBadge(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          _profileResultGameDetailController
                      .currentParticipant.value.championId !=
                  ""
              ? Container(
                  height: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                      ? 48
                      : 32,
                  width: _masterController.screenWidthSizeIsBiggerThanNexusOne()
                      ? 48
                      : 32,
                  child: Image.network(
                    _profileResultGameDetailController.getChampionBadgeUrl(),
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                )
              : Image.asset(
                  imageIconItemNone,
                  width: MediaQuery.of(context).size.width / 10,
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_spellImage1(context), _spellImage2(context)],
          ),
        ],
      );
    });
  }
}

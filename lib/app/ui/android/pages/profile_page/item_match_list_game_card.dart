import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/result_controllers/profile_result_controller/profile_result_game_detail_controller.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemMatchListGameCard extends StatefulWidget {
  final MatchDetail matchDetail;

  ItemMatchListGameCard(this.matchDetail);

  @override
  _ItemMatchListGameCardState createState() => _ItemMatchListGameCardState();
}

class _ItemMatchListGameCardState extends State<ItemMatchListGameCard> {
  final ProfileResultGameDetailController _profileResultGameDetailController =
      ProfileResultGameDetailController();

  static const int NEXUS_ONE_SCREEN = 800;

  @override
  void initState() {
    _profileResultGameDetailController
        .startProfileResultGame(widget.matchDetail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(vertical: 2),
      color: _profileResultGameDetailController.currentParticipant.value.win
          ? Colors.blue.withOpacity(0.2)
          : Colors.red.withOpacity(0.2),
      child: Column(
        children: [
          Row(
            children: [
              _championBadge(context),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_spellImage1(context), _spellImage2(context)],
              ),
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
    );
  }

  _userKDA() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 81),
          child: Text(
            _profileResultGameDetailController.currentParticipant.value.win ? "${AppLocalizations.of(context)!.gameVictory}" : "${AppLocalizations.of(context)!.gameDefeat}",
            style: GoogleFonts.montserrat(
              color: Colors.yellow,
              fontWeight: FontWeight.w400,
              fontSize:
              MediaQuery.of(context).size.width > NEXUS_ONE_SCREEN ? 18 : 13,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50),
          child: Text(
            "${_profileResultGameDetailController.currentParticipant.value.kills} / ${_profileResultGameDetailController.currentParticipant.value.deaths} / ${_profileResultGameDetailController.currentParticipant.value.assists}",
            style: GoogleFonts.montserrat(
              color: Colors.yellow,
              fontWeight: FontWeight.w400,
              fontSize:
                  MediaQuery.of(context).size.width > NEXUS_ONE_SCREEN ? 17 : 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Container _userPosition() {
    return Container(
      height: 30,
      width: 30,
      margin: EdgeInsets.only(left: 10),
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
      height: 35,
      width: 35,
      margin: EdgeInsets.only(left: last ? 8 : 0),
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
      height: 25,
      width: 25,
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
      height: 25,
      width: 25,
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
      return _profileResultGameDetailController
                  .currentParticipant.value.championId !=
              ""
          ? Container(
              height: 50,
              width: 50,
              child: Image.network(
                _profileResultGameDetailController.getChampionBadgeUrl(),
                width: MediaQuery.of(context).size.width / 10,
              ),
            )
          : Image.asset(
              imageIconItemNone,
              width: MediaQuery.of(context).size.width / 10,
            );
    });
  }
}

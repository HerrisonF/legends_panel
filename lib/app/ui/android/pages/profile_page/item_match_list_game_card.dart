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
      height: MediaQuery.of(context).size.height > 800 ? 70 : 50,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height > 800 ? 81 : 50),
          child: Text(
            _profileResultGameDetailController.currentParticipant.value.win ? "${AppLocalizations.of(context)!.gameVictory}" : "${AppLocalizations.of(context)!.gameDefeat}",
            style: GoogleFonts.montserrat(
              color: Colors.yellow,
              fontWeight: FontWeight.w400,
              fontSize:
              MediaQuery.of(context).size.width > NEXUS_ONE_SCREEN ? 18 : 8,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height > 800 ? 50 : 25),
          child: Text(
            "${_profileResultGameDetailController.currentParticipant.value.kills} / ${_profileResultGameDetailController.currentParticipant.value.deaths} / ${_profileResultGameDetailController.currentParticipant.value.assists}",
            style: GoogleFonts.montserrat(
              color: Colors.yellow,
              fontWeight: FontWeight.w400,
              fontSize:
                  MediaQuery.of(context).size.width > NEXUS_ONE_SCREEN ? 17 : 8,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Container _userPosition() {
    return Container(
      height: MediaQuery.of(context).size.height > 800 ? 30 : 20,
      width: MediaQuery.of(context).size.height > 800 ? 30 : 20,
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
      height: MediaQuery.of(context).size.height > 800 ? 35 : 23,
      width: MediaQuery.of(context).size.height > 800 ? 35 : 23,
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
      height: MediaQuery.of(context).size.height > 800 ? 25 : 15,
      width: MediaQuery.of(context).size.height > 800 ? 25 : 15,
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
      height: MediaQuery.of(context).size.height > 800 ? 25 : 15,
      width: MediaQuery.of(context).size.height > 800 ? 25 : 15,
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
              height: MediaQuery.of(context).size.height > 800 ? 50 : 30,
              width: MediaQuery.of(context).size.height > 800 ? 50 : 30,
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

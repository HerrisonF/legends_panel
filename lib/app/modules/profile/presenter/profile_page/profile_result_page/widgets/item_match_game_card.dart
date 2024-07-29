import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/profile/domain/models/match_detail_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/match_detail_component/match_detail_component.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/profile_result_page/profile_result_page_controller.dart';

class ItemMatchGameCard extends StatefulWidget {
  final MatchDetailModel matchDetail;
  final SummonerProfileModel summonerProfile;
  final ProfileResultController profileResultController;

  ItemMatchGameCard({
    required this.matchDetail,
    required this.summonerProfile,
    required this.profileResultController,
  });

  @override
  _ItemMatchGameCardState createState() => _ItemMatchGameCardState();
}

class _ItemMatchGameCardState extends State<ItemMatchGameCard> {
  @override
  void initState() {
    widget.matchDetail.info!.getProfileFromParticipant(
      puuid: widget.summonerProfile.summonerIdentificationModel!.puuid,
    );
    widget.matchDetail.info!.currentParticipant!.setItemIdIntoListItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapShowModalMatchDetail();
      },
      child: Container(
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        margin: EdgeInsets.symmetric(vertical: 2),
        color: widget.matchDetail.info!.currentParticipant!.win
            ? Colors.blue.withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
        child: Column(
          children: [
            Expanded(
              child: _userKDA(),
            ),
            Row(
              children: [
                Expanded(
                  child: _championBadgeAndSpell(),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children:
                        widget.matchDetail.info!.currentParticipant!.items!
                            .map((e) => _item(
                                  itemId: e,
                                ))
                            .toList(),
                  ),
                ),
                _userPosition(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onTapShowModalMatchDetail() {
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
        return MatchDetailComponent(
          matchDetail: widget.matchDetail,
        );
      },
    );
  }

  _userKDA() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              widget.matchDetail.info!.currentParticipant!.win
                  ? "${AppLocalizations.of(context)!.gameVictory}"
                  : "${AppLocalizations.of(context)!.gameDefeat}",
              style: GoogleFonts.montserrat(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Text(
            "${widget.matchDetail.info!.currentParticipant!.kills} / ${widget.matchDetail.info!.currentParticipant!.deaths} / ${widget.matchDetail.info!.currentParticipant!.assists}",
            style: GoogleFonts.montserrat(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Container _userPosition() {
    return Container(
      margin: EdgeInsets.only(right: 15),
      height: 20,
      width: 20,
      child: Image.network(
        widget.profileResultController.generalController.getPositionUrl(
          position: widget.matchDetail.info!.currentParticipant!.lane,
        ),
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.black45,
          );
        },
      ),
    );
  }

  Container _item({required int itemId}) {
    return Container(
      margin: EdgeInsets.only(left: 3),
      child: Container(
        height: 30,
        width: 30,
        child: Image.network(
          widget.profileResultController.generalController.getItemUrl(
            itemId: itemId,
          ),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  Widget _championBadgeAndSpell() {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          child: Stack(
            children: [
              Container(
                child: widget.profileResultController.generalController
                        .getChampionBadgeUrl(
                          widget
                              .matchDetail.info!.currentParticipant!.championId,
                        )
                        .isNotEmpty
                    ? Image.network(
                        widget.profileResultController.generalController
                            .getChampionBadgeUrl(
                          widget
                              .matchDetail.info!.currentParticipant!.championId,
                        ),
                      )
                    : Container(color: Colors.black54),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                    ),
                  ),
                  child: Text(
                    widget.matchDetail.info!.currentParticipant!.champLevel
                        .toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _spellImage(
              widget.matchDetail.info!.currentParticipant!.summoner1Id,
            ),
            _spellImage(
              widget.matchDetail.info!.currentParticipant!.summoner2Id,
            ),
          ],
        ),
      ],
    );
  }

  _spellImage(int id) {
    return Container(
      height: 25,
      width: 25,
      child: Image.network(
        widget.profileResultController.generalController.getSpellBadgeUrl(id),
      ),
    );
  }
}

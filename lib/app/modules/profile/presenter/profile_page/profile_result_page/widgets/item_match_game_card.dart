import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/profile/domain/models/match_detail_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';
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
  static const BLUE_TEAM = 100;

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
        // _showModalGeneralVision();
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
            Row(
              children: [
                _championBadgeAndSpell(),
                Row(
                  children: widget.matchDetail.info!.currentParticipant!.items!
                      .map((e) => _item(
                            itemId: e,
                          ))
                      .toList(),
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

// _showModalGeneralVision() {
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     enableDrag: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: const Radius.circular(20),
//         topRight: const Radius.circular(20),
//       ),
//     ),
//     builder: (BuildContext context) {
//       return GeneralVisionComponent(
//         matchDetail: widget.matchDetail,
//         participant:
//             _profileResultGameDetailController.currentParticipant.value,
//         primaryStylePerk: _profileResultGameDetailController.getSpellImage(1),
//         subStylePerk: _profileResultGameDetailController.getSpellImage(2),
//       );
//     },
//   );
// }

  _userKDA() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              widget.matchDetail.info!.currentParticipant!.win
                  ? "${AppLocalizations.of(context)!.gameVictory}"
                  : "${AppLocalizations.of(context)!.gameDefeat}",
              style: GoogleFonts.montserrat(
                color: Colors.yellow,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "${widget.matchDetail.info!.currentParticipant!.kills} / ${widget.matchDetail.info!.currentParticipant!.deaths} / ${widget.matchDetail.info!.currentParticipant!.assists}",
              style: GoogleFonts.montserrat(
                color: Colors.yellow,
                fontWeight: FontWeight.w400,
                fontSize: 12,
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
      margin: EdgeInsets.only(left: 5),
      height: 20,
      width: 20,
      child: Image.network(
        widget.profileResultController.generalController.getPositionUrl(
          position: widget.matchDetail.info!.currentParticipant!.teamPosition,
        ),
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.black45,
          );
        },
        width: MediaQuery.of(context).size.width / 16,
      ),
    );
  }

  Container _item({required int itemId}) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      child: Container(
        height: 25,
        width: 25,
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
          height: 32,
          width: 32,
          child: Image.network(
            widget.profileResultController.generalController
                .getChampionBadgeUrl(
              widget.matchDetail.info!.currentParticipant!.championId,
            ),
            width: MediaQuery.of(context).size.width / 10,
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
      height: 16,
      width: 16,
      margin: EdgeInsets.only(right: 5),
      child: Image.network(
        widget.profileResultController.generalController.getSpellBadgeUrl(id),
        width: MediaQuery.of(context).size.width / 20,
      ),
    );
  }
}

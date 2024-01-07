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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _championBadgeAndSpell(),
                Row(
                  children: [
                    // _itemBase(
                    //   item: _profileResultGameDetailController
                    //       .currentParticipant.value.item0,
                    // ),
                    // _itemBase(
                    //   item: _profileResultGameDetailController
                    //       .currentParticipant.value.item1,
                    // ),
                    // _itemBase(
                    //   item: _profileResultGameDetailController
                    //       .currentParticipant.value.item2,
                    // ),
                    // _itemBase(
                    //   item: _profileResultGameDetailController
                    //       .currentParticipant.value.item3,
                    // ),
                    // _itemBase(
                    //   item: _profileResultGameDetailController
                    //       .currentParticipant.value.item4,
                    // ),
                    // _itemBase(
                    //   item: _profileResultGameDetailController
                    //       .currentParticipant.value.item5,
                    // ),
                    // _itemBase(
                    //   item: _profileResultGameDetailController
                    //       .currentParticipant.value.item6,
                    //   last: true,
                    // ),
                  ],
                ),
                // _userPosition(),
              ],
            ),
            //_userKDA(),
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
//
// _userKDA() {
//   return Container(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           child: Text(
//             _profileResultGameDetailController.currentParticipant.value.win
//                 ? "${AppLocalizations.of(context)!.gameVictory}"
//                 : "${AppLocalizations.of(context)!.gameDefeat}",
//             style: GoogleFonts.montserrat(
//               color: Colors.yellow,
//               fontWeight: FontWeight.w400,
//               fontSize: 13,
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(left: 15),
//           child: Text(
//             "${_profileResultGameDetailController.currentParticipant.value.kills} / ${_profileResultGameDetailController.currentParticipant.value.deaths} / ${_profileResultGameDetailController.currentParticipant.value.assists}",
//             style: GoogleFonts.montserrat(
//               color: Colors.yellow,
//               fontWeight: FontWeight.w400,
//               fontSize: 12,
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Container _userPosition() {
//   return Container(
//     height: 20,
//     width: 20,
//     child: _profileResultGameDetailController
//                 .currentParticipant.value.teamPosition !=
//             ""
//         ? Image.network(
//             _profileResultGameDetailController.getPositionUrl(
//               _profileResultGameDetailController
//                   .currentParticipant.value.teamPosition,
//             ),
//             width: MediaQuery.of(context).size.width / 16,
//           )
//         : Image.asset(
//             imageIconItemNone,
//             width: MediaQuery.of(context).size.width / 16,
//           ),
//   );
// }
//
// _itemBase({required dynamic item, bool last = false}) {
//   return Container(
//     height: 25,
//     width: 25,
//     margin: EdgeInsets.only(left: last ? 10 : 0),
//     child: Container(
//       child: item > 0
//           ? Image.network(
//               _profileResultGameDetailController.getItemUrl(item.toString()),
//               width: MediaQuery.of(context).size.width / 16,
//               fit: BoxFit.cover,
//             )
//           : Image.asset(
//               imageIconItemNone,
//               width: MediaQuery.of(context).size.width / 16,
//               fit: BoxFit.cover,
//             ),
//     ),
//   );
// }
//
// _spellImage2(BuildContext context) {
//   return Container(
//     height: 16,
//     width: 16,
//     margin: EdgeInsets.only(right: 5),
//     child: _profileResultGameDetailController
//                 .currentParticipant.value.summoner2Id !=
//             ""
//         ? Image.network(
//             _profileResultGameDetailController.getSpellImage(2),
//             width: MediaQuery.of(context).size.width / 20,
//           )
//         : Image.network(
//             imageIconItemNone,
//             width: MediaQuery.of(context).size.width / 20,
//           ),
//   );
// }
//

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

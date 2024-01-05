import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';

class ProfileResultController {
  late SummonerProfileModel? summonerProfileModel;
  late final ProfileRepository profileRepository;
  late final GeneralController generalController;

  // ValueNotifier<MatchDetail> matchDetail = ValueNotifier(MatchDetail());
  // ValueNotifier<Participant> currentParticipant = ValueNotifier(Participant());

  // startProfileResultGame(MatchDetail matchDetail) async {
  //   this.matchDetail.value = matchDetail;
  //
  //   //getParticipantById(_masterController.userForProfile.id);
  // }

  ProfileResultController({
    required this.summonerProfileModel,
    required this.profileRepository,
    required this.generalController,
  });

  String getUserProfileImage() {
    return profileRepository.getProfileImage(
      profileIconId: summonerProfileModel!.profileIconId.toString(),
      version: generalController.lolConstantsModel.getLatestLolVersion(),
    );
  }

// getParticipantById(String summonerId) {
//   if (matchDetail.value.matchInfo.participants.length > 0) {
//     var list = matchDetail.value.matchInfo.participants.where((element) => element.summonerId == summonerId);
//     if(list.length > 0){
//       this.currentParticipant.value = list.first;
//       currentParticipant.notifyListeners();
//     }
//   }
// }

// getSpellImage(int spellId) {
//   // return _currentGameParticipantController.getSpellUrl(
//   //   _getParticipantSpellId(spellId),
//   // );
// }

// String getItemUrl(String itemId){
//   return _currentGameParticipantController.getItemUrl(itemId);
// }
//
// String getPositionUrl(String position){
//   return _currentGameParticipantController.getPositionUrl(position);
// }

// String _getParticipantSpellId(int id) {
//   if (id == 1) {
//     return currentParticipant.value.summoner1Id.toString();
//   } else {
//     return currentParticipant.value.summoner2Id.toString();
//   }
// }

// String getChampionBadgeUrl() {
//   return _currentGameParticipantController.getChampionBadgeUrl(
//       currentParticipant.value.championId.toString()
//   );
// }
}

import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_spectator.dart';

class CurrentGameResultController {
  String region = "";

  CurrentGameSpectator currentGameSpectator = CurrentGameSpectator();
  ValueNotifier<List<CurrentGameParticipant>> blueTeam = ValueNotifier([]);
  ValueNotifier<List<CurrentGameParticipant>> redTeam = ValueNotifier([]);

  static const BLUE_TEAM = 100;

  startController(CurrentGameSpectator currentGameSpectator, String region) {
   // this.region = _masterController.storedRegion.getKeyFromRegion(region)!;
    _clearOldCurrentGameSearch();
    setCurrentGameSpectator(currentGameSpectator);
    detachParticipantsIntoTeams();
  }

  setCurrentGameSpectator(CurrentGameSpectator spectator) {
    this.currentGameSpectator = spectator;
  }

  _clearOldCurrentGameSearch() {
    blueTeam.value.clear();
    redTeam.value.clear();
  }

  detachParticipantsIntoTeams() {
    for (int i = 0;
        i < currentGameSpectator.currentGameParticipants.length;
        i++) {
      CurrentGameParticipant currentGameParticipant =
          currentGameSpectator.currentGameParticipants[i];
      if (isPlayingMapWithBans()) {
        currentGameParticipant.currentGameBannedChampion =
            currentGameSpectator.bannedChampions[i];
      } else {
        currentGameParticipant.currentGameBannedChampion =
            CurrentGameBannedChampion();
      }

      if (currentGameParticipant.teamId == BLUE_TEAM) {
        blueTeam.value.add(currentGameParticipant);
      } else {
        redTeam.value.add(currentGameParticipant);
      }
    }
  }

  bool isPlayingMapWithBans() =>
      currentGameSpectator.bannedChampions.length > 0;

  int getCurrentGameMinutes() {
    return currentGameSpectator.gameLength;
  }
}

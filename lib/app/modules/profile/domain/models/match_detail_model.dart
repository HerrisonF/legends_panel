class MatchDetailModel {
  MetaDataModel? metaData;
  InfoModel? info;

  MatchDetailModel({
    required this.metaData,
    required this.info,
  });
}

class MetaDataModel {
  String dataVersion;
  String matchId;
  List<String> participantsPUUIDs;

  MetaDataModel({
    required this.dataVersion,
    required this.matchId,
    required this.participantsPUUIDs,
  });
}

class InfoModel {
  int gameCreation;
  int gameDuration;
  int gameEndTimestamp;
  int gameId;
  String gameMode;
  String gameName;
  int gameStartTimestamp;
  String gameVersion;
  int mapId;
  List<ParticipantModel> participants;
  String platformId;
  int queueId;
  List<TeamModel> teams;
  String tournamentCode;

  /// Esse modelo é referente ao Profile pesquisado
  ParticipantModel? currentParticipant;

  InfoModel({
    required this.gameCreation,
    required this.gameDuration,
    required this.gameEndTimestamp,
    required this.gameId,
    required this.gameMode,
    required this.gameStartTimestamp,
    required this.participants,
    required this.platformId,
    required this.queueId,
    required this.teams,
    required this.gameName,
    required this.mapId,
    required this.gameVersion,
    required this.tournamentCode,
  });

  ParticipantModel getProfileFromParticipant({
    required String puuid,
  }) {
    List<ParticipantModel> participantsTemp =
        participants.where((element) => element.puuid == puuid).toList();
    currentParticipant = participantsTemp.first;
    return currentParticipant!;
  }
}

class TeamModel {
  List<BanModel> bans;
  ObjetivosModel objetivos;
  int teamId;
  bool win;

  TeamModel({
    required this.bans,
    required this.objetivos,
    required this.teamId,
    required this.win,
  });
}

class ObjetivosModel {
  ObjetivoModel baron;
  ObjetivoModel champion;
  ObjetivoModel dragon;
  ObjetivoModel inhibitor;
  ObjetivoModel riftHerald;
  ObjetivoModel tower;

  ObjetivosModel({
    required this.baron,
    required this.champion,
    required this.dragon,
    required this.inhibitor,
    required this.riftHerald,
    required this.tower,
  });
}

class ObjetivoModel {
  bool first;
  int kills;

  ObjetivoModel({
    required this.first,
    required this.kills,
  });
}

class BanModel {
  int championId;
  int pickTurn;

  BanModel({
    required this.championId,
    required this.pickTurn,
  });
}

class ParticipantModel {
  int assists;
  int baronKills;
  int bountyLevel;
  int champExperience;
  int champLevel;
  int championId;
  String championName;
  int championTransform;
  int consumablesPurchased;
  int damageDealtToBuildings;
  int damageDealtToObjectives;
  int damageDealtToTurrets;
  int damageSelfMitigated;
  int deaths;
  int detectorWardsPlaced;
  int doubleKills;
  int dragonKills;
  bool firstBloodAssist;
  bool firstBloodKill;
  bool firstTowerAssist;
  bool firstTowerKill;
  bool gameEndedInEarlySurrender;
  bool gameEndedInSurrender;
  int goldEarned;
  int goldSpent;
  String individualPosition;
  int inhibitorKills;
  int inhibitorTakedowns;
  int inhibitorLost;
  int item0;
  int item1;
  int item2;
  int item3;
  int item4;
  int item5;
  int item6;
  int itemsPurchased;
  int killingSpress;
  int kills;
  String lane;
  int largestCriticalStrike;
  int largestKillingSpree;
  int largestMultiKill;
  int longestTimeSpentLiving;
  int magicDamageDealt;
  int magicDamageDealtToChampions;
  int magicDamageTaken;
  int neutralMinionsKilled;
  int nexusKills;
  int nexusLost;
  int nexusTakeDowns;
  int objectivesStolen;
  int objectiveStolenAssists;
  int participantId;
  int pentaKills;
  PerksModel? perks;
  int physicalDamageDealt;
  int physicalDamageDealtToChampions;
  int physicalDamageTaken;
  int profileIcon;
  String puuid;
  int quadraKills;
  String riotIdName;
  String riotIdTagline;
  String role;
  int sightWardsBoughtInGame;
  int spell1Casts;
  int spell2Casts;
  int spell3Casts;
  int spell4Casts;
  int summoner1Casts;
  int summoner1Id;
  int summoner2Casts;
  int summoner2Id;
  String summonerId;
  int summonerLevel;
  String summonerName;
  bool teamEarlySurrendered;
  int teamId;
  String teamPosition;
  int timeCCingOthers;
  int timePlayed;
  int totalDamageDealt;
  int totalDamageDealtToChampions;
  int totalDamageShieldedOnTeammates;
  int totalDamageTaken;
  int totalHeal;
  int totalHealsOnTeammates;
  int totalMinionsKilled;
  int totalTimeCCDealt;
  int totalTimeSpentDead;
  int totalUnitsHealed;
  int tripleKills;
  int trueDamageDealt;
  int trueDamageDealtToChampions;
  int trueDamageTaken;
  int turretKills;
  int turretTakedowns;
  int turretsLost;
  int unrealKills;
  int visionScore;
  int visionWardsBoughtInGame;
  int wardsKilled;
  int wardsPlaced;
  bool win;

  List<int>? items;

  ParticipantModel({
    required this.championId,
    required this.kills,
    required this.teamId,
    required this.puuid,
    required this.summonerLevel,
    required this.win,
    required this.summonerId,
    required this.summonerName,
    required this.perks,
    required this.assists,
    required this.baronKills,
    required this.bountyLevel,
    required this.champExperience,
    required this.championName,
    required this.championTransform,
    required this.champLevel,
    required this.consumablesPurchased,
    required this.damageDealtToBuildings,
    required this.damageDealtToObjectives,
    required this.damageDealtToTurrets,
    required this.damageSelfMitigated,
    required this.deaths,
    required this.detectorWardsPlaced,
    required this.doubleKills,
    required this.dragonKills,
    required this.firstBloodAssist,
    required this.firstBloodKill,
    required this.firstTowerAssist,
    required this.firstTowerKill,
    required this.gameEndedInEarlySurrender,
    required this.gameEndedInSurrender,
    required this.goldEarned,
    required this.goldSpent,
    required this.individualPosition,
    required this.inhibitorKills,
    required this.inhibitorLost,
    required this.inhibitorTakedowns,
    required this.item0,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
    required this.item5,
    required this.item6,
    required this.itemsPurchased,
    required this.killingSpress,
    required this.lane,
    required this.largestCriticalStrike,
    required this.largestKillingSpree,
    required this.largestMultiKill,
    required this.longestTimeSpentLiving,
    required this.magicDamageDealt,
    required this.magicDamageDealtToChampions,
    required this.magicDamageTaken,
    required this.neutralMinionsKilled,
    required this.nexusKills,
    required this.nexusLost,
    required this.nexusTakeDowns,
    required this.objectivesStolen,
    required this.objectiveStolenAssists,
    required this.participantId,
    required this.pentaKills,
    required this.physicalDamageDealt,
    required this.physicalDamageDealtToChampions,
    required this.physicalDamageTaken,
    required this.profileIcon,
    required this.quadraKills,
    required this.riotIdName,
    required this.riotIdTagline,
    required this.role,
    required this.sightWardsBoughtInGame,
    required this.spell1Casts,
    required this.spell2Casts,
    required this.spell3Casts,
    required this.spell4Casts,
    required this.summoner1Casts,
    required this.summoner1Id,
    required this.summoner2Casts,
    required this.summoner2Id,
    required this.teamEarlySurrendered,
    required this.teamPosition,
    required this.timeCCingOthers,
    required this.timePlayed,
    required this.totalDamageDealt,
    required this.totalDamageDealtToChampions,
    required this.totalDamageShieldedOnTeammates,
    required this.totalDamageTaken,
    required this.totalHeal,
    required this.totalHealsOnTeammates,
    required this.totalMinionsKilled,
    required this.totalTimeCCDealt,
    required this.totalTimeSpentDead,
    required this.totalUnitsHealed,
    required this.tripleKills,
    required this.trueDamageDealt,
    required this.trueDamageDealtToChampions,
    required this.trueDamageTaken,
    required this.turretKills,
    required this.turretsLost,
    required this.turretTakedowns,
    required this.unrealKills,
    required this.visionScore,
    required this.visionWardsBoughtInGame,
    required this.wardsKilled,
    required this.wardsPlaced,
  });

  /// Essa função cria uma lista de itens que vieram da item0,item1,item2 ...
  setItemIdIntoListItems(){
    items = [];
    items!.add(item0);
    items!.add(item1);
    items!.add(item2);
    items!.add(item3);
    items!.add(item4);
    items!.add(item5);
    items!.add(item6);
  }
}

class PerksModel {
  StatPerksModel statPerks;
  List<PerkStyleModel> styles;

  PerksModel({
    required this.statPerks,
    required this.styles,
  });
}

class StatPerksModel {
  int defense;
  int flex;
  int offense;

  StatPerksModel({
    required this.defense,
    required this.flex,
    required this.offense,
  });

  factory StatPerksModel.fromJson(Map<String, dynamic> json) {
    return StatPerksModel(
      defense: json['defense'] ?? 0,
      flex: json['flex'] ?? 0,
      offense: json['offense'] ?? 0,
    );
  }
}

class PerkStyleModel {
  String description;
  int style;
  List<PerkStyleSelectionModel> selections;

  PerkStyleModel({
    required this.description,
    required this.style,
    required this.selections,
  });
}

class PerkStyleSelectionModel {
  int perk;
  int var1;
  int var2;
  int var3;

  PerkStyleSelectionModel({
    required this.perk,
    required this.var1,
    required this.var2,
    required this.var3,
  });
}

class MatchDetailDTO {
  MetaDataDTO? metaDataDTO;
  InfoDTO? infoDTO;

  MatchDetailDTO({
    required this.metaDataDTO,
    required this.infoDTO,
  });

  factory MatchDetailDTO.fromJson(Map<String, dynamic> json) {
    return MatchDetailDTO(
      metaDataDTO: json['metadata'] != null ? MetaDataDTO.fromJson(json['metadata']) : null,
      infoDTO: json['info'] != null ? InfoDTO.fromJson(json['info']) : null,
    );
  }
}

class MetaDataDTO {
  String dataVersion;
  String matchId;
  List<String> participantsPUUIDs;

  MetaDataDTO({
    required this.dataVersion,
    required this.matchId,
    required this.participantsPUUIDs,
  });

  factory MetaDataDTO.fromJson(Map<String, dynamic> json) {
    return MetaDataDTO(
      dataVersion: json['dataVersion'] ?? "",
      matchId: json['matchId'] ?? "",
      participantsPUUIDs: json['participants'] != null
          ? (json['participants'] as List).map<String>((e) => e).toList()
          : [],
    );
  }
}

class InfoDTO {
  int gameCreation;
  int gameDuration;
  int gameEndTimestamp;
  int gameId;
  String gameMode;
  String gameName;
  int gameStartTimestamp;
  String gameVersion;
  int mapId;
  List<ParticipantDTO> participantDTOs;
  String platformId;
  int queueId;
  List<TeamDTO> teamDTOs;
  String tournamentCode;

  InfoDTO({
    required this.gameCreation,
    required this.gameDuration,
    required this.gameEndTimestamp,
    required this.gameId,
    required this.gameMode,
    required this.gameStartTimestamp,
    required this.participantDTOs,
    required this.platformId,
    required this.queueId,
    required this.teamDTOs,
    required this.gameName,
    required this.mapId,
    required this.gameVersion,
    required this.tournamentCode,
  });

  factory InfoDTO.fromJson(Map<String, dynamic> json) {
    return InfoDTO(
      gameCreation: json['gameCreation'] ?? 0,
      gameDuration: json['gameDuration'] ?? 0,
      gameEndTimestamp: json['gameEndTimestamp'] ?? 0,
      gameId: json['gameId'] ?? 0,
      gameMode: json['gameMode'] ?? "",
      gameName: json['gameName'] ?? "",
      gameStartTimestamp: json['gameStartTimestamp'] ?? 0,
      mapId: json['mapId'] ?? 0,
      participantDTOs: json['participants'] != null
          ? json['participants']
              .map<ParticipantDTO>(
                  (element) => ParticipantDTO.fromJson(element))
              .toList()
          : [],
      platformId: json['platformId'] ?? "",
      queueId: json['queueId'] ?? 0,
      teamDTOs: json['teams'] != null
          ? (json['teams'] as List)
              .map<TeamDTO>((element) => TeamDTO.fromJson(element))
              .toList()
          : [],
      tournamentCode: json['tournamentCode'] ?? "",
      gameVersion: json['gameVersion'] ?? "",
    );
  }
}

class TeamDTO {
  List<BanDTO> banDTOs;
  ObjetivosDTO objetivosDTO;
  int teamId;
  bool win;

  TeamDTO({
    required this.banDTOs,
    required this.objetivosDTO,
    required this.teamId,
    required this.win,
  });

  factory TeamDTO.fromJson(Map<String, dynamic> json) {
    return TeamDTO(
      teamId: json['teamId'] ?? 0,
      win: json['win'] ?? false,
      banDTOs: json['bans'] != null
          ? (json['bans'] as List).map((ban) => BanDTO.fromJson(ban)).toList()
          : [],
      objetivosDTO: ObjetivosDTO.fromJson(
        json['objectives'],
      ),
    );
  }
}

class ObjetivosDTO {
  ObjetivoDTO baronDTO;
  ObjetivoDTO championDTO;
  ObjetivoDTO dragonDTO;
  ObjetivoDTO inhibitorDTO;
  ObjetivoDTO riftHeraldDTO;
  ObjetivoDTO towerDTO;

  ObjetivosDTO({
    required this.baronDTO,
    required this.championDTO,
    required this.dragonDTO,
    required this.inhibitorDTO,
    required this.riftHeraldDTO,
    required this.towerDTO,
  });

  factory ObjetivosDTO.fromJson(Map<String, dynamic> json) {
    return ObjetivosDTO(
      baronDTO: ObjetivoDTO.fromJson(json['baron']),
      championDTO: ObjetivoDTO.fromJson(json['champion']),
      dragonDTO: ObjetivoDTO.fromJson(json['dragon']),
      inhibitorDTO: ObjetivoDTO.fromJson(json['inhibitor']),
      riftHeraldDTO: ObjetivoDTO.fromJson(json['riftHerald']),
      towerDTO: ObjetivoDTO.fromJson(json['tower']),
    );
  }
}

class ObjetivoDTO {
  bool first;
  int kills;

  ObjetivoDTO({
    required this.first,
    required this.kills,
  });

  factory ObjetivoDTO.fromJson(Map<String, dynamic> json) {
    return ObjetivoDTO(
      first: json['first'] ?? false,
      kills: json['kills'] ?? 0,
    );
  }
}

class BanDTO {
  int championId;
  int pickTurn;

  BanDTO({
    required this.championId,
    required this.pickTurn,
  });

  factory BanDTO.fromJson(Map<String, dynamic> json) {
    return BanDTO(
      championId: json['championId'] ?? 0,
      pickTurn: json['pickTurn'] ?? 0,
    );
  }
}

class ParticipantDTO {
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
  PerksDTO? perksDTO;
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

  ParticipantDTO({
    required this.championId,
    required this.kills,
    required this.teamId,
    required this.puuid,
    required this.summonerLevel,
    required this.win,
    required this.summonerId,
    required this.summonerName,
    required this.perksDTO,
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

  factory ParticipantDTO.fromJson(Map<String, dynamic> json) {
    return ParticipantDTO(
      assists: json['assists'] ?? 0,
      baronKills: json['baronKills'] ?? 0,
      bountyLevel: json['bountyLevel'] ?? 0,
      champExperience: json['champExperience'] ?? 0,
      champLevel: json['champLevel'] ?? 0,
      championId: json['championId'] ?? 0,
      championName: json['championName'] ?? "",
      championTransform: json['championTransform'] ?? 0,
      consumablesPurchased: json['consumablesPurchased'] ?? 0,
      damageDealtToBuildings: json['damageDealtToBuildings'] ?? 0,
      damageDealtToObjectives: json['damageDealtToObjectives'] ?? 0,
      damageDealtToTurrets: json['damageDealtToTurrets'] ?? 0,
      damageSelfMitigated: json['damageSelfMitigated'] ?? 0,
      deaths: json['deaths'] ?? 0,
      detectorWardsPlaced: json['detectorWardsPlaced'] ?? 0,
      doubleKills: json['doubleKills'] ?? 0,
      dragonKills: json['dragonKills'] ?? 0,
      firstBloodAssist: json['firstBloodAssist'] ?? false,
      firstBloodKill: json['firstBloodKill'] ?? false,
      firstTowerAssist: json['firstTowerAssist'] ?? false,
      firstTowerKill: json['firstTowerKill'] ?? false,
      gameEndedInEarlySurrender: json['gameEndedInEarlySurrender'] ?? false,
      gameEndedInSurrender: json['gameEndedInSurrender'] ?? false,
      goldEarned: json['goldEarned'] ?? 0,
      goldSpent: json['goldSpent'] ?? 0,
      individualPosition: json['individualPosition'] ?? "",
      inhibitorKills: json['inhibitorKills'] ?? 0,
      inhibitorTakedowns: json['inhibitorTakedowns'] ?? 0,
      inhibitorLost: json['inhibitorLost'] ?? 0,
      item0: json['item0'] ?? 0,
      item1: json['item1'] ?? 0,
      item2: json['item2'] ?? 0,
      item3: json['item3'] ?? 0,
      item4: json['item4'] ?? 0,
      item5: json['item5'] ?? 0,
      item6: json['item6'] ?? 0,
      itemsPurchased: json['itemsPurchased'] ?? 0,
      killingSpress: json['killingSpress'] ?? 0,
      kills: json['kills'] ?? 0,
      lane: json['lane'] ?? "",
      largestCriticalStrike: json['largestCriticalStrike'] ?? 0,
      largestKillingSpree: json['largestKillingSpree'] ?? 0,
      largestMultiKill: json['largestMultiKill'] ?? 0,
      longestTimeSpentLiving: json['longestTimeSpentLiving'] ?? 0,
      magicDamageDealt: json['magicDamageDealt'] ?? 0,
      magicDamageDealtToChampions: json['magicDamageDealtToChampions'] ?? 0,
      magicDamageTaken: json['magicDamageTaken'] ?? 0,
      neutralMinionsKilled: json['neutralMinionsKilled'] ?? 0,
      nexusKills: json['nexusKills'] ?? 0,
      nexusLost: json['nexusLost'] ?? 0,
      nexusTakeDowns: json['nexusTakeDowns'] ?? 0,
      objectivesStolen: json['objectivesStolen'] ?? 0,
      objectiveStolenAssists: json['objectiveStolenAssists'] ?? 0,
      participantId: json['participantId'] ?? 0,
      pentaKills: json['pentaKills'] ?? 0,
      perksDTO:
          json['pentaKills'] != null ? PerksDTO.fromJson(json['perks']) : null,
      physicalDamageDealt: json['physicalDamageDealt'] ?? 0,
      physicalDamageDealtToChampions:
          json['physicalDamageDealtToChampions'] ?? 0,
      physicalDamageTaken: json['physicalDamageTaken'] ?? 0,
      profileIcon: json['profileIcon'] ?? 0,
      puuid: json['puuid'] ?? "",
      quadraKills: json['quadraKills'] ?? 0,
      riotIdName: json['riotIdName'] ?? "",
      riotIdTagline: json['riotIdTagLine'] ?? "",
      role: json['role'] ?? "",
      sightWardsBoughtInGame: json['sightWardsBoughtInGame'] ?? 0,
      spell1Casts: json['spell1Casts'] ?? 0,
      spell2Casts: json['spell2Casts'] ?? 0,
      spell3Casts: json['spell3Casts'] ?? 0,
      spell4Casts: json['spell4Casts'] ?? 0,
      summoner1Casts: json['summoner1Casts'] ?? 0,
      summoner1Id: json['summoner1Id'] ?? 0,
      summoner2Casts: json['summoner2Casts'] ?? 0,
      summoner2Id: json['summoner2Id'] ?? 0,
      summonerId: json['summonerId'] ?? "",
      summonerLevel: json['summonerLevel'] ?? 0,
      summonerName: json['summonerName'] ?? "",
      teamEarlySurrendered: json['teamEarlySurrendered'] ?? false,
      teamId: json['teamId'] ?? 0,
      teamPosition: json['teamPosition'] ?? "",
      timeCCingOthers: json['timeCCingOthers'] ?? 0,
      timePlayed: json['timePlayed'] ?? 0,
      totalDamageDealt: json['totalDamageDealt'] ?? 0,
      totalDamageDealtToChampions: json['totalDamageDealtToChampions'] ?? 0,
      totalDamageShieldedOnTeammates:
          json['totalDamageShieldedOnTeammates'] ?? 0,
      totalDamageTaken: json['totalDamageTaken'] ?? 0,
      totalHeal: json['totalHeal'] ?? 0,
      totalHealsOnTeammates: json['totalHealsOnTeammates'] ?? 0,
      totalMinionsKilled: json['totalMinionsKilled'] ?? 0,
      totalTimeCCDealt: json['totalTimeCCDealt'] ?? 0,
      totalTimeSpentDead: json['totalTimeSpentDead'] ?? 0,
      totalUnitsHealed: json['totalUnitsHealed'] ?? 0,
      tripleKills: json['tripleKills'] ?? 0,
      trueDamageDealt: json['trueDamageDealt'] ?? 0,
      trueDamageDealtToChampions: json['trueDamageDealtToChampions'] ?? 0,
      trueDamageTaken: json['trueDamageTaken'] ?? 0,
      turretKills: json['turretKills'] ?? 0,
      turretTakedowns: json['turretTakedowns'] ?? 0,
      turretsLost: json['turretsLost'] ?? 0,
      unrealKills: json['unrealKills'] ?? 0,
      visionScore: json['visionScore'] ?? 0,
      visionWardsBoughtInGame: json['visionWardsBoughtInGame'] ?? 0,
      wardsKilled: json['wardsKilled'] ?? 0,
      wardsPlaced: json['wardsPlaced'] ?? 0,
      win: json['win'] ?? false,
    );
  }
}

class PerksDTO {
  StatPerksDTO statPerksDTO;
  List<PerkStyleDTO> stylesDTO;

  PerksDTO({
    required this.statPerksDTO,
    required this.stylesDTO,
  });

  factory PerksDTO.fromJson(Map<String, dynamic> json) {
    return PerksDTO(
        statPerksDTO: StatPerksDTO.fromJson(json['statPerks']),
        stylesDTO: json['styles'] != null
            ? (json['styles'] as List)
                .map<PerkStyleDTO>((element) => PerkStyleDTO.fromJson(element))
                .toList()
            : []);
  }
}

class StatPerksDTO {
  int defense;
  int flex;
  int offense;

  StatPerksDTO({
    required this.defense,
    required this.flex,
    required this.offense,
  });

  factory StatPerksDTO.fromJson(Map<String, dynamic> json) {
    return StatPerksDTO(
      defense: json['defense'] ?? 0,
      flex: json['flex'] ?? 0,
      offense: json['offense'] ?? 0,
    );
  }
}

class PerkStyleDTO {
  String description;
  int style;
  List<PerkStyleSelectionDTO> selectionsDTO;

  PerkStyleDTO({
    required this.description,
    required this.style,
    required this.selectionsDTO,
  });

  factory PerkStyleDTO.fromJson(Map<String, dynamic> json) {
    return PerkStyleDTO(
      description: json['description'] ?? "",
      style: json['style'] ?? 0,
      selectionsDTO: json['selections'] != null
          ? (json['selections'] as List)
              .map<PerkStyleSelectionDTO>(
                  (e) => PerkStyleSelectionDTO.fromJson(e))
              .toList()
          : [],
    );
  }
}

class PerkStyleSelectionDTO {
  int perk;
  int var1;
  int var2;
  int var3;

  PerkStyleSelectionDTO({
    required this.perk,
    required this.var1,
    required this.var2,
    required this.var3,
  });

  factory PerkStyleSelectionDTO.fromJson(Map<String, dynamic> json) {
    return PerkStyleSelectionDTO(
      perk: json['perk'] ?? 0,
      var1: json['var1'] ?? 0,
      var2: json['var2'] ?? 0,
      var3: json['var3'] ?? 0,
    );
  }
}

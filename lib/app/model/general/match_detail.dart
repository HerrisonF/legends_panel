class MatchDetail {

  MatchMetaData matchMetaData = MatchMetaData();
  MatchInfo matchInfo = MatchInfo();

  MatchDetail();

  MatchDetail.fromJson(Map<String, dynamic> json) {
    matchMetaData = MatchMetaData.fromJson(json['metadata']);
    matchInfo = MatchInfo.fromJson(json['info']);
  }

  @override
  String toString() {
    return 'MatchDetail{matchMetaData: $matchMetaData, matchInfo: $matchInfo}';
  }


}

class MatchMetaData {
  dynamic dataVersion = "";
  dynamic matchId = "";
  List<String> participantsId = [];

  MatchMetaData();

  MatchMetaData.fromJson(Map<String, dynamic> json){
    dataVersion = json['dataVersion']??"";
    matchId = json['matchId']??"";

    if (json['participants'] != null) {
      for(String id in json['participants']){
        participantsId.add(id);
      }
    }
  }



}

class MatchInfo {
  dynamic gameCreation = 0;
  dynamic gameDuration = 0;
  dynamic gameEndTimestamp = 0;
  dynamic gameId = 0;
  dynamic gameMode = "";
  dynamic gameStartTimestamp = 0;
  dynamic mapId = 0;
  List<Participant> participants = [];
  dynamic platformId = "";
  dynamic queueId = 0;
  List<Team> teams = [];

  MatchInfo();

  MatchInfo.fromJson(Map<String, dynamic> json){
    gameCreation = json['gameCreation'];
    gameDuration = json['gameDuration'];
    gameEndTimestamp = json['gameEndTimestamp'];
    gameId = json['gameId'];
    gameMode = json['gameMode'];
    gameStartTimestamp = json['gameStartTimestamp'];
    mapId = json['mapId'];
    if(json['participants'] != null){
      json['participants'].forEach((element){
        participants.add(Participant.fromJson(element));
      });
    }
    platformId = json['platformId'];
    queueId = json['queueId'];
    if(json['teams']!= null){
      json['teams'].forEach((element){
        teams.add(Team.fromJson(element));
      });
    }
  }
}

class Team {
  List<Ban> bans = [];
  Objectives objectives = Objectives();
  Team.fromJson(Map<String, dynamic> json) {
    if (json['bans'] != null) {
      json['bans'].forEach((ban) {
        bans.add(Ban.fromJson(ban));
      });
    }
    objectives = Objectives.fromJson(json['objectives']);
  }

  @override
  String toString() {
    return 'Team{bans: $bans, objectives: $objectives}';
  }

}

class Objectives {
  Objective baron = Objective();
  Objective champion = Objective();
  Objective dragon = Objective();
  Objective inhibitor = Objective();
  Objective riftHerald = Objective();
  Objective tower = Objective();
  dynamic teamId = 0;
  dynamic win = false;

  Objectives();

  Objectives.fromJson(Map<String, dynamic> json){
    baron = Objective.fromJson(json['baron']);
    champion = Objective.fromJson(json['champion']);
    dragon = Objective.fromJson(json['dragon']);
    inhibitor = Objective.fromJson(json['inhibitor']);
    riftHerald = Objective.fromJson(json['riftHerald']);
    tower = Objective.fromJson(json['tower']);
    teamId = json['teamId'];
    win = json['win'];
  }

  @override
  String toString() {
    return 'Objectives{baron: $baron, champion: $champion, dragon: $dragon, inhibitor: $inhibitor, riftHerald: $riftHerald, tower: $tower, teamId: $teamId, win: $win}';
  }


}

class Objective {

  dynamic first = false;
  dynamic kills = 0;

  Objective();

  Objective.fromJson(Map<String, dynamic> json){
    first = json['first'];
    kills = json['kills'];
  }

  @override
  String toString() {
    return 'Objective{first: $first, kills: $kills}';
  }


}

class Ban {
  dynamic championId = 0;
  dynamic pickTurn = 0;

  Ban.fromJson(Map<String, dynamic> json) {
    championId = json['championId'];
    pickTurn = json['pickTurn'];
  }

  @override
  String toString() {
    return 'Ban{championId: $championId, pickTurn: $pickTurn}';
  }
}

class Participant {

  dynamic assists = 0;
  dynamic baronKills = 0;
  dynamic bountyLevel  = 0;
  dynamic champExperience = 0;
  dynamic champLevel = 0;
  dynamic championId = 0;
  dynamic championName = "";
  dynamic championTransform = 0;
  dynamic consumablesPurchased = 0;
  dynamic damageDealtToBuildings = 0;
  dynamic damageDealtToObjectives = 0;
  dynamic damageDealtToTurrets = 0;
  dynamic damageSelfMitigated = 0;
  dynamic deaths = 0;
  dynamic detectorWardsPlaced = 0;
  dynamic doubleKills = 0;
  dynamic dragonKills = 0;
  dynamic firstBloodAssist = false;
  dynamic firstBloodKill = false;
  dynamic firstTowerAssist = false;
  dynamic firstTowerKill = false;
  dynamic gameEndedInEarlySurrender = false;
  dynamic gameEndedInSurrender = false;
  dynamic goldEarned = 0;
  dynamic goldSpent = 0;
  dynamic individualPosition = 0;
  dynamic inhibitorKills = 0;
  dynamic inhibitorTakedowns = 0;
  dynamic inhibitorLost = 0;
  dynamic item0 = 0;
  dynamic item1 = 0;
  dynamic item2 = 0;
  dynamic item3 = 0;
  dynamic item4 = 0;
  dynamic item5 = 0;
  dynamic item6 = 0;
  dynamic itemsPurchased = 0;
  dynamic killingSpress = 0;
  dynamic kills = 0;
  dynamic lane = "";
  dynamic largestCriticalStrike = 0;
  dynamic largestKillingSpree = 0;
  dynamic largestMultiKill = 0;
  dynamic longestTimeSpentLiving = 0;
  dynamic magicDamageDealt = 0;
  dynamic magicDamageDealtToChampions = 0;
  dynamic magicDamageTaken = 0;
  dynamic neutralMinionsKilled = 0;
  dynamic nexusKills = 0;
  dynamic nexusLost = 0;
  dynamic nexusTakeDowns = 0;
  dynamic objectivesStolen = 0;
  dynamic objectiveStolenAssists = 0;
  dynamic participantId = 0;
  dynamic pentaKills = 0;
  Perk perk = Perk();
  dynamic physicalDamageDealt = 0;
  dynamic physicalDamageDealtToChampions = 0;
  dynamic physicalDamageTaken = 0;
  dynamic profileIcon = 0;
  dynamic puuid = "";
  dynamic quadraKills = 0;
  dynamic riotIdName = "";
  dynamic riotIdTagline = "";
  dynamic role = "";
  dynamic sightWardsBoughtInGame = 0;
  dynamic spell1Casts = 0;
  dynamic spell2Casts = 0;
  dynamic spell3Casts = 0;
  dynamic spell4Casts = 0;
  dynamic summoner1Casts = 0;
  dynamic summoner1Id = 0;
  dynamic summoner2Casts = 0;
  dynamic summoner2Id = 0;
  dynamic summonerId = "";
  dynamic summonerLevel = 0;
  dynamic summonerName = "";
  dynamic teamEarlySurrendered = false;
  dynamic teamId = 0;
  dynamic teamPosition = "";
  dynamic timeCCingOthers = 0;
  dynamic timePlayed = 0;
  dynamic totalDamageDealt = 0;
  dynamic totalDamageDealtToChampions = 0;
  dynamic totalDamageShieldedOnTeammates = 0;
  dynamic totalDamageTaken = 0;
  dynamic totalHeal = 0;
  dynamic totalHealsOnTeammates = 0;
  dynamic totalMinionsKilled = 0;
  dynamic totalTimeCCDealt = 0;
  dynamic totalTimeSpentDead = 0;
  dynamic totalUnitsHealed = 0;
  dynamic tripleKills = 0;
  dynamic trueDamageDealt = 0;
  dynamic trueDamageDealtToChampions = 0;
  dynamic trueDamageTaken = 0;
  dynamic turretKills = 0;
  dynamic turretTakedowns = 0;
  dynamic turretsLost = 0;
  dynamic unrealKills = 0;
  dynamic visionScore = 0;
  dynamic visionWardsBoughtInGame = 0;
  dynamic wardsKilled = 0;
  dynamic wardsPlaced = 0;
  dynamic win = false;

  Participant();

  Participant.fromJson(Map<String, dynamic> json){
    assists = json['assists'];
    baronKills = json['baronKills'];
    bountyLevel = json['bountyLevel'];
    champExperience = json['champExperience'];
    champLevel = json['champLevel'];
    championId = json['championId'];
    championName = json['championName'];
    championTransform = json['championTransform'];
    consumablesPurchased = json['consumablesPurchased'];
    damageDealtToBuildings = json['damageDealtToBuildings'];
    damageDealtToObjectives = json['damageDealtToObjectives'];
    damageDealtToTurrets = json['damageDealtToTurrets'];
    damageSelfMitigated = json['damageSelfMitigated'];
    deaths = json['deaths'];
    detectorWardsPlaced = json['detectorWardsPlaced'];
    doubleKills = json['doubleKills'];
    dragonKills = json['dragonKills'];
    firstBloodAssist = json['firstBloodAssist'];
    firstBloodKill = json['firstBloodKill'];
    firstTowerAssist = json['firstTowerAssist'];
    firstTowerKill = json['firstTowerKill'];
    gameEndedInEarlySurrender = json['gameEndedInEarlySurrender'];
    gameEndedInSurrender = json['gameEndedInSurrender'];
    goldEarned = json['goldEarned'];
    goldSpent = json['goldSpent'];
    individualPosition = json['individualPosition'];
    inhibitorKills = json['inhibitorKills'];
    inhibitorTakedowns = json['inhibitorTakedowns'];
    inhibitorLost = json['inhibitorLost'];
    item0 = json['item0'];
    item1 = json['item1'];
    item2 = json['item2'];
    item3 = json['item3'];
    item4 = json['item4'];
    item5 = json['item5'];
    item6 = json['item6'];
    itemsPurchased = json['itemsPurchased'];
    killingSpress = json['killingSpress'];
    kills = json['kills'];
    lane = json['lane'];
    largestCriticalStrike = json['largestCriticalStrike'];
    largestKillingSpree = json['largestKillingSpree'];
    largestMultiKill = json['largestMultiKill'];
    longestTimeSpentLiving = json['longestTimeSpentLiving'];
    magicDamageDealt = json['magicDamageDealt'];
    magicDamageDealtToChampions = json['magicDamageDealtToChampions'];
    magicDamageTaken = json['magicDamageTaken'];
    neutralMinionsKilled = json['neutralMinionsKilled'];
    nexusKills = json['nexusKills'];
    nexusLost = json['nexusLost'];
    nexusTakeDowns = json['nexusTakeDowns'];
    objectivesStolen = json['objectivesStolen'];
    objectiveStolenAssists = json['objectiveStolenAssists'];
    participantId = json['participantId'];
    pentaKills = json['pentaKills'];
    perk = Perk.fromJson(json['perks']);
    physicalDamageDealt = json['physicalDamageDealt'];
    physicalDamageDealtToChampions = json['physicalDamageDealtToChampions'];
    physicalDamageTaken = json['physicalDamageTaken'];
    profileIcon = json['profileIcon'];
    puuid = json['puuid'];
    quadraKills = json['quadraKills'];
    riotIdName = json['riotIdName'];
    riotIdTagline = json['riotIdTagLine'];
    role = json['role'];
    sightWardsBoughtInGame = json['sightWardsBoughtInGame'];
    spell1Casts = json['spell1Casts'];
    spell2Casts = json['spell2Casts'];
    spell3Casts = json['spell3Casts'];
    spell4Casts = json['spell4Casts'];
    summoner1Casts = json['summoner1Casts'];
    summoner1Id = json['summoner1Id'];
    summoner2Casts = json['summoner2Casts'];
    summoner2Id = json['summoner2Id'];
    summonerId = json['summonerId'];
    summonerLevel = json['summonerLevel'];
    summonerName = json['summonerName'];
    teamEarlySurrendered = json['teamEarlySurrendered'];
    teamId = json['teamId'];
    teamPosition = json['teamPosition'];
    timeCCingOthers = json['timeCCingOthers'];
    timePlayed = json['timePlayed'];
    totalDamageDealt = json['totalDamageDealt'];
    totalDamageDealtToChampions = json['totalDamageDealtToChampions'];
    totalDamageShieldedOnTeammates = json['totalDamageShieldedOnTeammates'];
    totalDamageTaken = json['totalDamageTaken'];
    totalHeal = json['totalHeal'];
    totalHealsOnTeammates = json['totalHealsOnTeammates'];
    totalMinionsKilled = json['totalMinionsKilled'];
    totalTimeCCDealt = json['totalTimeCCDealt'];
    totalTimeSpentDead = json['totalTimeSpentDead'];
    totalUnitsHealed = json['totalUnitsHealed'];
    tripleKills = json['tripleKills'];
    trueDamageDealt = json['trueDamageDealt'];
    trueDamageDealtToChampions = json['trueDamageDealtToChampions'];
    trueDamageTaken = json['trueDamageTaken'];
    turretKills = json['turretKills'];
    turretTakedowns = json['turretTakedowns'];
    turretsLost = json['turretsLost'];
    unrealKills = json['unrealKills'];
    visionScore = json['visionScore'];
    visionWardsBoughtInGame = json['visionWardsBoughtInGame'];
    wardsKilled = json['wardsKilled'];
    wardsPlaced = json['wardsPlaced'];
    win = json['win'];
  }

  @override
  String toString() {
    return 'Participant{assists: $assists, baronKills: $baronKills, bountyLevel: $bountyLevel, champExperience: $champExperience, champLevel: $champLevel, championId: $championId, championName: $championName, championTransform: $championTransform, consumablesPurchased: $consumablesPurchased, damageDealtToBuildings: $damageDealtToBuildings, damageDealtToObjectives: $damageDealtToObjectives, damageDealtToTurrets: $damageDealtToTurrets, damageSelfMitigated: $damageSelfMitigated, deaths: $deaths, detectorWardsPlaced: $detectorWardsPlaced, doubleKills: $doubleKills, dragonKills: $dragonKills, firstBloodAssist: $firstBloodAssist, firstBloodKill: $firstBloodKill, firstTowerAssist: $firstTowerAssist, firstTowerKill: $firstTowerKill, gameEndedInEarlySurrender: $gameEndedInEarlySurrender, gameEndedInSurrender: $gameEndedInSurrender, goldEarned: $goldEarned, goldSpent: $goldSpent, individualPosition: $individualPosition, inhibitorKills: $inhibitorKills, inhibitorTakedowns: $inhibitorTakedowns, inhibitorLost: $inhibitorLost, item0: $item0, item1: $item1, item2: $item2, item3: $item3, item4: $item4, item5: $item5, item6: $item6, itemsPurchased: $itemsPurchased, killingSpress: $killingSpress, kills: $kills, lane: $lane, largestCriticalStrike: $largestCriticalStrike, largestKillingSpree: $largestKillingSpree, largestMultiKill: $largestMultiKill, longestTimeSpentLiving: $longestTimeSpentLiving, magicDamageDealt: $magicDamageDealt, magicDamageDealtToChampions: $magicDamageDealtToChampions, magicDamageTaken: $magicDamageTaken, neutralMinionsKilled: $neutralMinionsKilled, nexusKills: $nexusKills, nexusLost: $nexusLost, nexusTakeDowns: $nexusTakeDowns, objectivesStolen: $objectivesStolen, objectiveStolenAssists: $objectiveStolenAssists, participantId: $participantId, pentaKills: $pentaKills, perk: $perk, physicalDamageDealt: $physicalDamageDealt, physicalDamageDealtToChampions: $physicalDamageDealtToChampions, physicalDamageTaken: $physicalDamageTaken, profileIcon: $profileIcon, puuid: $puuid, quadraKills: $quadraKills, riotIdName: $riotIdName, riotIdTagline: $riotIdTagline, role: $role, sightWardsBoughtInGame: $sightWardsBoughtInGame, spell1Casts: $spell1Casts, spell2Casts: $spell2Casts, spell3Casts: $spell3Casts, spell4Casts: $spell4Casts, summoner1Casts: $summoner1Casts, summoner1Id: $summoner1Id, summoner2Casts: $summoner2Casts, summoner2Id: $summoner2Id, summonerId: $summonerId, summonerLevel: $summonerLevel, summonerName: $summonerName, teamEarlySurrendered: $teamEarlySurrendered, teamId: $teamId, teamPosition: $teamPosition, timeCCingOthers: $timeCCingOthers, timePlayed: $timePlayed, totalDamageDealt: $totalDamageDealt, totalDamageDealtToChampions: $totalDamageDealtToChampions, totalDamageShieldedOnTeammates: $totalDamageShieldedOnTeammates, totalDamageTaken: $totalDamageTaken, totalHeal: $totalHeal, totalHealsOnTeammates: $totalHealsOnTeammates, totalMinionsKilled: $totalMinionsKilled, totalTimeCCDealt: $totalTimeCCDealt, totalTimeSpentDead: $totalTimeSpentDead, totalUnitsHealed: $totalUnitsHealed, tripleKills: $tripleKills, trueDamageDealt: $trueDamageDealt, trueDamageDealtToChampions: $trueDamageDealtToChampions, trueDamageTaken: $trueDamageTaken, turretKills: $turretKills, turretTakedowns: $turretTakedowns, turretsLost: $turretsLost, unrealKills: $unrealKills, visionScore: $visionScore, visionWardsBoughtInGame: $visionWardsBoughtInGame, wardsKilled: $wardsKilled, wardsPlaced: $wardsPlaced, win: $win}';
  }
}

class Perk {
  StatPerks statPerks = StatPerks();
  List<GameStyle> styles = [];

  Perk();

  Perk.fromJson(Map<String, dynamic> json){
    statPerks = StatPerks.fromJson(json['statPerks']);
    if(json['styles']!= null){
      json['styles'].forEach((element){
        styles.add(GameStyle.fromJson(element));
      });
    }
  }
}

class StatPerks {
  dynamic defense = "";
  dynamic flex = "";
  dynamic offense = "";

  StatPerks();

  StatPerks.fromJson(Map<String, dynamic> json){
    defense = json['defense'];
    flex = json['flex'];
    offense = json['offense'];
  }
}

class GameStyle {
  dynamic description = "";
  dynamic style = 0;
  List<Selection> selections = [];

  GameStyle();

  GameStyle.fromJson(Map<String, dynamic> json){
    description = json['description'];
    style = json['style'];
    if(json['selections'] != null){
      json['selections'].forEach((element){
        selections.add(Selection.fromJson(element));
      });
    }
  }
}

class Selection {
  dynamic perk = 0;
  dynamic var1 = 0;
  dynamic var2 = 0;
  dynamic var3 = 0;

  Selection();

  Selection.fromJson(Map<String, dynamic> json){
    perk = json['perk'];
    var1 = json['var1'];
    var2 = json['var2'];
    var3 = json['var3'];
  }

}

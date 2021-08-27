class MatchDetail {
  int gameId = 0;
  String platformId = "";
  int gameCreation = 0;
  int gameDuration = 0;
  int queueId = 0;
  int mapId = 0;
  int seasonId = 0;
  String gameVersion = "";
  String gameMode = "";
  String gameType = "";
  List<Team> teams = [];
  List<Participant> participants = [];
  List<ParticipantIdentitie> participantIdentities = [];

  MatchDetail();

  MatchDetail.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'] ?? 0;
    platformId = json['platformId'] ?? "";
    gameCreation = json['gameCreation'] ?? 0;
    gameDuration = json['gameDuration'] ?? 0;
    queueId = json['queueId'] ?? 0;
    mapId = json['mapId'] ?? 0;
    seasonId = json['seasonId'] ?? 0;
    gameVersion = json['gameVersion'] ?? "";
    gameMode = json['gameMode'] ?? "";
    gameType = json['gameType'] ?? "";
    if (json['teams'] != null) {
      json['teams'].forEach((team) {
        teams.add(Team.fromJson(team));
      });
    }
    if(json['participants']!=null){
      json['participants'].forEach((participant){
        participants.add(Participant.fromJson(participant));
      });
    }
    if(json['participantIdentities']!=null){
      json['participantIdentities'].forEach((participant){
        participantIdentities.add(ParticipantIdentitie.fromJson(participant));
      });
    }
  }

  @override
  String toString() {
    return 'MatchDetail{gameId: $gameId, platformId: $platformId, gameCreation: $gameCreation, gameDuration: $gameDuration, queueId: $queueId, mapId: $mapId, seasonId: $seasonId, gameVersion: $gameVersion, gameMode: $gameMode, gameType: $gameType, teams: $teams, participants: $participants, participantIdentities: $participantIdentities}';
  }
}

class Team {
  int teamId = 0;
  String win = "";
  bool firstBlood = false;
  bool firstTower = false;
  bool firstInhibitor = false;
  bool firstBaron = false;
  bool firstDragon = false;
  bool firstRiftHerald = false;
  int towerKills = 0;
  int inhibitorKills = 0;
  int baronKills = 0;
  int dragonKills = 0;
  int vilemawKills = 0;
  int riftHeraldKills = 0;
  int dominionVictoryScore = 0;
  List<Ban> bans = [];


  Team.fromJson(Map<String, dynamic> json) {
    teamId = json['teamId'] ?? 0;
    win = json['win'] ?? "";
    firstBlood = json['firstBlood'] ?? false;
    firstTower = json['firstTower'] ?? false;
    firstInhibitor = json['firstInhibitor'] ?? false;
    firstBaron = json['firstBaron'] ?? false;
    firstDragon = json['firstDragon'] ?? false;
    firstRiftHerald = json['firstRiftHerald'] ?? false;
    towerKills = json['towerKills'] ?? 0;
    inhibitorKills = json['inhibitorKills'] ?? 0;
    baronKills = json['baronKills'] ?? 0;
    dragonKills = json['dragonKills'] ?? 0;
    vilemawKills = json['viewmawKills'] ?? 0;
    riftHeraldKills = json['riftHeraldKills'] ?? 0;
    dominionVictoryScore = json['dominionVictoryScore'] ?? 0;
    if (json['bans'] != null) {
      json['bans'].forEach((ban) {
        bans.add(Ban.fromJson(ban));
      });
    }
  }

  @override
  String toString() {
    return 'Team{teamId: $teamId, win: $win, firstBlood: $firstBlood, firstTower: $firstTower, firstInhibitor: $firstInhibitor, firstBaron: $firstBaron, firstDragon: $firstDragon, firstRiftHerald: $firstRiftHerald, towerKills: $towerKills, inhibitorKills: $inhibitorKills, baronKills: $baronKills, dragonKills: $dragonKills, vilemawKills: $vilemawKills, riftHeraldKills: $riftHeraldKills, dominionVictoryScore: $dominionVictoryScore, bans: $bans}';
  }
}

class Ban {
  int championId = 0;
  int pickTurn = 0;

  Ban.fromJson(Map<String, dynamic> json) {
    championId = json['championId'] ?? 0;
    pickTurn = json['pickTurn'] ?? 0;
  }

  @override
  String toString() {
    return 'Ban{championId: $championId, pickTurn: $pickTurn}';
  }
}

class Participant {
  dynamic participantId = 0;
  dynamic teamId = 0;
  dynamic championId = 0;
  dynamic spell1d = 0;
  dynamic spell2d = 0;
  Status stats = Status();
  TimeLine timeLine = TimeLine();

  Participant();

  Participant.fromJson(Map<String, dynamic> json){
    participantId = json['participantId']??0;
    teamId = json['teamId']??0;
    championId = json['championId']??0;
    spell1d = json['spell1Id']??0;
    spell2d = json['spell2Id']??0;
    if(json['stats']!=null){
      stats = Status.fromJson(json['stats']);
    }
    if(json['timeline']!= null){
      timeLine = TimeLine.fromJson(json['timeline']);
    }
  }

  @override
  String toString() {
    return 'Participant{participantId: $participantId, teamId: $teamId, championId: $championId, spell1d: $spell1d, spell2d: $spell2d, stats: $stats, timeLine: $timeLine}';
  }
}

class ParticipantIdentitie {
  int participantId = 0;
  Player player = Player();

  ParticipantIdentitie();
  
  ParticipantIdentitie.fromJson(Map<String, dynamic> json){
    participantId = json['participantId']??0;
    player = Player.fromJson(json['player']);
  }

  @override
  String toString() {
    return 'ParticipantIdentitie{participantId: $participantId, player: $player}';
  }
}

class Player {
  String platformId = "";
  String accountId = "";
  String summonerName = "";
  String summonerId = "";
  String currentPlatformId = "";
  String currentAccountId = "";
  String matchHistoryUri = "";
  int profileIcon = 0;


  Player();

  Player.fromJson(Map<String, dynamic> json) {
    platformId = json['platformId'];
    accountId = json['accountId'];
    summonerName = json['summonerName'];
    summonerId = json['summonerId'];
    currentPlatformId = json['currentPlatformId'];
    currentAccountId = json['currentAccountId'];
    matchHistoryUri = json['matchHistoryUri'];
    profileIcon = json['profileIcon'];
  }

  @override
  String toString() {
    return 'Player{platformId: $platformId, accountId: $accountId, summonerName: $summonerName, summonerId: $summonerId, currentPlatformId: $currentPlatformId, currentAccountId: $currentAccountId, matchHistoryUri: $matchHistoryUri, profileIcon: $profileIcon}';
  }
}

class Status {
  dynamic participantId = 0;
  bool win = false;
  dynamic item0 = 0;
  dynamic item1 = 0;
  dynamic item2 = 0;
  dynamic item3 = 0;
  dynamic item4 = 0;
  dynamic item5 = 0;
  dynamic item6 = 0;
  dynamic kills = 0;
  dynamic deaths = 0;
  dynamic assists = 0;
  dynamic largestKillingSpree = 0;
  dynamic largestMultiKill = 0;
  dynamic killingSprees = 0;
  dynamic longestTimeSpentLiving = 0;
  dynamic doubleKills = 0;
  dynamic tripleKills = 0;
  dynamic quadraKills = 0;
  dynamic pentaKills = 0;
  dynamic unrealKills = 0;
  dynamic totalDamageDealt = 0;
  dynamic magicDamageDealt = 0;
  dynamic physicalDamageDealt = 0;
  dynamic trueDamageDealt = 0;
  dynamic largestCriticalStrike = 0;
  dynamic totalDamageDealtToChampions = 0;
  dynamic magicDamageDealtToChampions = 0;
  dynamic physicalDamageDealtToChampions = 0;
  dynamic trueDamageDealtToChampions = 0;
  dynamic totalHeal = 0;
  dynamic totalUnitsHealed = 0;
  dynamic damageSelfMitigated = 0;
  dynamic damageDealtToObjectives = 0;
  dynamic damageDealtToTurrets = 0;
  dynamic visionScore = 0;
  dynamic timeCCingOthers = 0;
  dynamic totalDamageTaken = 0;
  dynamic magicalDamageTaken = 0;
  dynamic physicalDamageTaken = 0;
  dynamic trueDamageTaken = 0;
  dynamic goldEarned = 0;
  dynamic goldSpent = 0;
  dynamic turretKills = 0;
  dynamic inhibitorKills = 0;
  dynamic totalMinionsKilled = 0;
  dynamic neutralMinionsKilled = 0;
  dynamic neutralMinionsKilledTeamJungle = 0;
  dynamic neutralMinionsKilledEnemyJungle = 0;
  dynamic totalTimeCrowdControlDealt = 0;
  dynamic champLevel = 0;
  dynamic visionWardsBoughtInGame = 0;
  dynamic sightWardsBoughtInGame = 0;
  dynamic wardsPlaced = 0;
  dynamic wardsKilled = 0;
  bool firstBloodKill = false;
  bool firstBloodAssist = false;
  bool firstTowerKill = false;
  bool firstTowerAssist = false;
  dynamic combatPlayerScore = 0;
  dynamic objectivePlayerScore = 0;
  dynamic totalPlayerScore = 0;
  dynamic totalScoreRank = 0;
  dynamic playerScore0 = 0;
  dynamic playerScore1 = 0;
  dynamic playerScore2 = 0;
  dynamic playerScore3 = 0;
  dynamic playerScore4 = 0;
  dynamic playerScore5 = 0;
  dynamic playerScore6 = 0;
  dynamic playerScore7 = 0;
  dynamic playerScore8 = 0;
  dynamic playerScore9 = 0;
  dynamic perk0 = 0;
  dynamic perk0Var1 = 0;
  dynamic perk0Var2 = 0;
  dynamic perk0Var3 = 0;
  dynamic perk1 = 0;
  dynamic perk1Var1 = 0;
  dynamic perk1Var2 = 0;
  dynamic perk1Var3 = 0;
  dynamic perk2 = 0;
  dynamic perk2Var1 = 0;
  dynamic perk2Var2 = 0;
  dynamic perk2Var3 = 0;
  dynamic perk3 = 0;
  dynamic perk3Var1 = 0;
  dynamic perk3Var2 = 0;
  dynamic perk3Var3 = 0;
  dynamic perk4 = 0;
  dynamic perk4Var1 = 0;
  dynamic perk4Var2 = 0;
  dynamic perk4Var3 = 0;
  dynamic perk5 = 0;
  dynamic perk5Var1 = 0;
  dynamic perk5Var2 = 0;
  dynamic perk5Var3 = 0;
  dynamic perkPrimaryStyle = 0;
  dynamic perkSubStyle = 0;
  dynamic statPerk0 = 0;
  dynamic statPerk1 = 0;
  dynamic statPerk2 = 0;

  Status();

  Status.fromJson(Map<String, dynamic> json){
    participantId = json['participantId']??0;
    win = json['win']??0;
    item0 = json['item0']??0;
    item1 = json['item1']??0;
    item2 = json['item2']??0;
    item3 = json['item3']??0;
    item4 = json['item4']??0;
    item5 = json['item5']??0;
    item6 = json['item6']??0;
    kills = json['kills']??0;
    deaths = json['deaths']??0;
    assists = json['assists']??0;
    largestKillingSpree = json['largestKillingSpree']??0;
    largestMultiKill = json['largestMultiKill']??0;
    killingSprees = json['killingSprees']??0;
    longestTimeSpentLiving = json['longestTimeSpentLiving']??0;
    doubleKills = json['doubleKills']??0;
    tripleKills = json['tripleKills']??0;
    quadraKills = json['quadraKills']??0;
    pentaKills = json['pentaKills']??0;
    unrealKills = json['unrealKills']??0;
    totalDamageDealt = json['totalDamageDealt']??0;
    magicDamageDealt = json['magicDamageDealt']??0;
    physicalDamageDealt = json['physicalDamageDealt']??0;
    trueDamageDealt = json['trueDamageDealt']??0;
    largestCriticalStrike = json['largestCriticalStrike']??0;
    totalDamageDealtToChampions = json['totalDamageDealtToChampions']??0;
    magicDamageDealtToChampions = json['magicDamageDealtToChampions']??0;
    physicalDamageDealtToChampions = json['physicalDamageDealtToChampions']??0;
    trueDamageDealtToChampions = json['trueDamageDealtToChampions']??0;
    totalHeal = json['totalHeal']??0;
    totalUnitsHealed = json['totalUnitsHealed']??0;
    damageSelfMitigated = json['damageSelfMitigated']??0;
    damageDealtToObjectives = json['damageDealtToObjectives']??0;
    damageDealtToTurrets = json['damageDealtToTurrets']??0;
    visionScore = json['visionScore']??0;
    timeCCingOthers = json['timeCCingOthers']??0;
    totalDamageTaken = json['totalDamageTaken']??0;
    magicalDamageTaken = json['magicalDamageTaken']??0;
    physicalDamageTaken = json['physicalDamageTaken']??0;
    trueDamageTaken = json['trueDamageTaken']??0;
    goldEarned = json['goldEarned']??0;
    goldSpent = json['goldSpent']??0;
    turretKills = json['turretKills']??0;
    inhibitorKills = json['inhibitorKills']??0;
    totalMinionsKilled = json['totalMinionsKilled']??0;
    neutralMinionsKilled = json['neutralMinionsKilled']??0;
    neutralMinionsKilledTeamJungle = json['neutralMinionsKilledTeamJungle']??0;
    neutralMinionsKilledEnemyJungle = json['neutralMinionsKilledEnemyJungle']??0;
    totalTimeCrowdControlDealt = json['totalTimeCrowdControlDealt']??0;
    champLevel = json['champLevel']??0;
    visionWardsBoughtInGame = json['visionWardsBoughtInGame']??0;
    sightWardsBoughtInGame = json['sightWardsBoughtInGame']??0;
    wardsPlaced = json['wardsPlaced']??0;
    wardsKilled = json['wardsKilled']??0;
    firstBloodKill = json['firstBloodKill']??false;
    firstBloodAssist = json['firstBloodAssist']??false;
    firstTowerKill = json['firstTowerKill']??false;
    firstTowerAssist = json['firstTowerAssist']??false;
    combatPlayerScore = json['combatPlayerScore']??0;
    objectivePlayerScore = json['objectivePlayerScore']??0;
    totalPlayerScore = json['totalPlayerScore']??0;
    totalScoreRank = json['totalScoreRank']??0;
    playerScore0 = json['playerScore0']??0;
    playerScore1 = json['playerScore1']??0;
    playerScore2 = json['playerScore2']??0;
    playerScore3 = json['playerScore3']??0;
    playerScore4 = json['playerScore4']??0;
    playerScore5 = json['playerScore5']??0;
    playerScore6 = json['playerScore6']??0;
    playerScore7 = json['playerScore7']??0;
    playerScore8 = json['playerScore8']??0;
    playerScore9 = json['playerScore9']??0;
    perk0 = json['perk0']??0;
    perk0Var1 = json['perk0Var1']??0;
    perk0Var2 = json['perk0Var2']??0;
    perk0Var3 = json['perk0Var3']??0;
    perk1 = json['perk1']??0;
    perk1Var1 = json['perk1Var1']??0;
    perk1Var2 = json['perk1Var2']??0;
    perk1Var3 = json['perk1Var3']??0;
    perk2 = json['perk2']??0;
    perk2Var1 = json['perk2Var1']??0;
    perk2Var2 = json['perk2Var2']??0;
    perk2Var3 = json['perk2Var3']??0;
    perk3 = json['perk3']??0;
    perk3Var1 = json['perk3Var1']??0;
    perk3Var2 = json['perk3Var2']??0;
    perk3Var3 = json['perk3Var3']??0;
    perk4 = json['perk4']??0;
    perk4Var1 = json['perk4Var1']??0;
    perk4Var2 = json['perk4Var2']??0;
    perk4Var3 = json['perk4Var3']??0;
    perk5 = json['perk5']??0;
    perk5Var1 = json['perk5Var1']??0;
    perk5Var2 = json['perk5Var2']??0;
    perk5Var3 = json['perk5Var3']??0;
    perkPrimaryStyle = json['perkPrimaryStyle']??0;
    perkSubStyle = json['perkSubStyle']??0;
    statPerk0 = json['statPerk0']??0;
    statPerk1 = json['statPerk1']??0;
    statPerk2 = json['statPerk2']??0;
  }

  @override
  String toString() {
    return 'Status{participantId: $participantId, win: $win, item0: $item0, item1: $item1, item2: $item2, item3: $item3, item4: $item4, item5: $item5, item6: $item6, kills: $kills, deaths: $deaths, assists: $assists, largestKillingSpree: $largestKillingSpree, largestMultiKill: $largestMultiKill, killingSprees: $killingSprees, longestTimeSpentLiving: $longestTimeSpentLiving, doubleKills: $doubleKills, tripleKills: $tripleKills, quadraKills: $quadraKills, pentaKills: $pentaKills, unrealKills: $unrealKills, totalDamageDealt: $totalDamageDealt, magicDamageDealt: $magicDamageDealt, physicalDamageDealt: $physicalDamageDealt, trueDamageDealt: $trueDamageDealt, largestCriticalStrike: $largestCriticalStrike, totalDamageDealtToChampions: $totalDamageDealtToChampions, magicDamageDealtToChampions: $magicDamageDealtToChampions, physicalDamageDealtToChampions: $physicalDamageDealtToChampions, trueDamageDealtToChampions: $trueDamageDealtToChampions, totalHeal: $totalHeal, totalUnitsHealed: $totalUnitsHealed, damageSelfMitigated: $damageSelfMitigated, damageDealtToObjectives: $damageDealtToObjectives, damageDealtToTurrets: $damageDealtToTurrets, visionScore: $visionScore, timeCCingOthers: $timeCCingOthers, totalDamageTaken: $totalDamageTaken, magicalDamageTaken: $magicalDamageTaken, physicalDamageTaken: $physicalDamageTaken, trueDamageTaken: $trueDamageTaken, goldEarned: $goldEarned, goldSpent: $goldSpent, turretKills: $turretKills, inhibitorKills: $inhibitorKills, totalMinionsKilled: $totalMinionsKilled, neutralMinionsKilled: $neutralMinionsKilled, neutralMinionsKilledTeamJungle: $neutralMinionsKilledTeamJungle, neutralMinionsKilledEnemyJungle: $neutralMinionsKilledEnemyJungle, totalTimeCrowdControlDealt: $totalTimeCrowdControlDealt, champLevel: $champLevel, visionWardsBoughtInGame: $visionWardsBoughtInGame, sightWardsBoughtInGame: $sightWardsBoughtInGame, wardsPlaced: $wardsPlaced, wardsKilled: $wardsKilled, firstBloodKill: $firstBloodKill, firstBloodAssist: $firstBloodAssist, firstTowerKill: $firstTowerKill, firstTowerAssist: $firstTowerAssist, combatPlayerScore: $combatPlayerScore, objectivePlayerScore: $objectivePlayerScore, totalPlayerScore: $totalPlayerScore, totalScoreRank: $totalScoreRank, playerScore0: $playerScore0, playerScore1: $playerScore1, playerScore2: $playerScore2, playerScore3: $playerScore3, playerScore4: $playerScore4, playerScore5: $playerScore5, playerScore6: $playerScore6, playerScore7: $playerScore7, playerScore8: $playerScore8, playerScore9: $playerScore9, perk0: $perk0, perk0Var1: $perk0Var1, perk0Var2: $perk0Var2, perk0Var3: $perk0Var3, perk1: $perk1, perk1Var1: $perk1Var1, perk1Var2: $perk1Var2, perk1Var3: $perk1Var3, perk2: $perk2, perk2Var1: $perk2Var1, perk2Var2: $perk2Var2, perk2Var3: $perk2Var3, perk3: $perk3, perk3Var1: $perk3Var1, perk3Var2: $perk3Var2, perk3Var3: $perk3Var3, perk4: $perk4, perk4Var1: $perk4Var1, perk4Var2: $perk4Var2, perk4Var3: $perk4Var3, perk5: $perk5, perk5Var1: $perk5Var1, perk5Var2: $perk5Var2, perk5Var3: $perk5Var3, perkPrimaryStyle: $perkPrimaryStyle, perkSubStyle: $perkSubStyle, statPerk0: $statPerk0, statPerk1: $statPerk1, statPerk2: $statPerk2}';
  }
}

class TimeLine {
  int participantId = 0;
  CreepsPerMinDeltas creepsPerMinDeltas = CreepsPerMinDeltas();
  CreepsPerMinDeltas xpPerMinDeltas = CreepsPerMinDeltas();
  CreepsPerMinDeltas goldPerMinDeltas = CreepsPerMinDeltas();
  CreepsPerMinDeltas csDiffPerMinDeltas = CreepsPerMinDeltas();
  CreepsPerMinDeltas xpDiffPerMinDeltas = CreepsPerMinDeltas();
  CreepsPerMinDeltas damageTakenPerMinDeltas = CreepsPerMinDeltas();
  CreepsPerMinDeltas damageTakenDiffPerMinDeltas = CreepsPerMinDeltas();
  String role = "";
  String lane = "";


  TimeLine();

  TimeLine.fromJson(Map<String, dynamic> json) {
    participantId = json['participantId'] ?? 0;
    if(json['creepsPerMinDeltas']!=null){
      creepsPerMinDeltas =
          CreepsPerMinDeltas.fromJson(json['creepsPerMinDeltas']);
    }
    if(json['xpPerMinDeltas']!= null){
      xpPerMinDeltas = CreepsPerMinDeltas.fromJson(json['xpPerMinDeltas']);
    }
    if(json['goldPerMinDeltas']!=null){
      goldPerMinDeltas = CreepsPerMinDeltas.fromJson(json['goldPerMinDeltas']);
    }
    if(json['csDiffPerMinDeltas']!=null){
      csDiffPerMinDeltas =
          CreepsPerMinDeltas.fromJson(json['csDiffPerMinDeltas']);
    }
    if(json['xpDiffPerMinDeltas']!=null){
      xpDiffPerMinDeltas =
          CreepsPerMinDeltas.fromJson(json['xpDiffPerMinDeltas']);
    }
    if(json['damageTakenPerMinDeltas']!=null){
      damageTakenPerMinDeltas =
          CreepsPerMinDeltas.fromJson(json['damageTakenPerMinDeltas']);
    }
    if(json['damageTakenDiffPerMinDeltas']!=null){
      damageTakenDiffPerMinDeltas =
          CreepsPerMinDeltas.fromJson(json['damageTakenDiffPerMinDeltas']);
    }
    role = json['role']??"";
    lane = json['lane']??"";
  }

  @override
  String toString() {
    return 'TimeLine{participantId: $participantId, creepsPerMinDeltas: $creepsPerMinDeltas, xpPerMinDeltas: $xpPerMinDeltas, goldPerMinDeltas: $goldPerMinDeltas, csDiffPerMinDeltas: $csDiffPerMinDeltas, xpDiffPerMinDeltas: $xpDiffPerMinDeltas, damageTakenPerMinDeltas: $damageTakenPerMinDeltas, damageTakenDiffPerMinDeltas: $damageTakenDiffPerMinDeltas, role: $role, lane: $lane}';
  }
}

class CreepsPerMinDeltas {
  dynamic d1020 = 0.0;
  dynamic d010 = 0.0;

  CreepsPerMinDeltas();

  CreepsPerMinDeltas.fromJson(Map<String, dynamic> json) {
    d1020 = json['10-20']??0.0;
    d010 = json['0-10']??0.0;
  }

  @override
  String toString() {
    return 'CreepsPerMinDeltas{d1020: $d1020, d010: $d010}';
  }
}

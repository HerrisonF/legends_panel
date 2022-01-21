class GameTimeLineModel {
  MatchMetaData matchMetaData = MatchMetaData();
  GameInfo gameInfo = GameInfo();

  GameTimeLineModel();

  GameTimeLineModel.fromJson(Map<String, dynamic> json){
    matchMetaData = MatchMetaData.fromJson(json["metadata"]);
    gameInfo = GameInfo.fromJson(json["info"]);
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

class GameInfo {
  dynamic frameInterval = "";
  List<Frame> frames = [];
  dynamic gameId = "";
  List<ParticipantTimeLine> participants = [];

  GameInfo();

  GameInfo.fromJson(Map<String, dynamic> json){
    frameInterval = json["frameInterval"];
    if(json["frames"] != null){
      json["frames"].forEach((frameElement){
        frames.add(Frame.fromJson(frameElement));
      });
    }
    gameId = json["gameId"];
    if(json["participants"] != null ){
      json["participants"].forEach((participantElement){
        participants.add(ParticipantTimeLine.fromJson(participantElement));
      });
    }
  }
}

class Frame {
  List<GameEvent> events = [];
  List<ParticipantFrame> participantFrames = [];
  dynamic timeStamp = "";

  Frame();

  Frame.fromJson(Map<String, dynamic> json){
    if(json["events"] != null) {
      json["events"].forEach((eventElement) {
        events.add(GameEvent.fromJson(eventElement));
      });
    }
    if(json["participantFrames"] != null){
      for(final keyFrame in json["participantFrames"].keys){
        final participantFrame = json["participantFrames"][keyFrame];
        participantFrames.add(ParticipantFrame.fromJson(participantFrame));
      }
    }
    timeStamp = json["timestamp"];
  }
}

class GameEvent {
  dynamic realTimestamp = "";
  dynamic timeStamp = "";
  dynamic type = "";

  GameEvent();

  GameEvent.fromJson(Map<String, dynamic> json){
    realTimestamp = json["realTimestamp"];
    timeStamp = json["timestamp"];
    type = json["type"];
  }
}

class ParticipantTimeLine {
  dynamic participantId = "";
  dynamic puuId = "";

  ParticipantTimeLine();

  ParticipantTimeLine.fromJson(Map<String, dynamic> json ){
    participantId = json["participantId"];
    puuId = json["puuid"];
  }
}

class ParticipantFrame {
  ChampionStats championStats = ChampionStats();
  dynamic currentGold = 0;
  DamageStats damageStats = DamageStats();
  dynamic goldPerSecond = 0;
  dynamic jungleMinionsKilled = 0;
  dynamic level = 0;
  dynamic minionsKilled = 0;
  dynamic participantId = "";
  Position position = Position();
  dynamic timeEnemySpentControlled = 0;
  dynamic totalGold = 0;
  dynamic xp = 0;

  ParticipantFrame();

  ParticipantFrame.fromJson(Map<String, dynamic> json){
    championStats = ChampionStats.fromJson(json["championStats"]);
    currentGold = json["currentGold"];
    damageStats = DamageStats.fromJson(json["damageStats"]);
    goldPerSecond = json["goldPerSecond"];
    jungleMinionsKilled = json["jungleMinionsKilled"];
    level = json["level"];
    minionsKilled = json["minionsKilled"];
    participantId = json["participantId"];
    position = Position.fromJson(json["position"]);
    timeEnemySpentControlled = json["timeEnemySpentControlled"];
    totalGold = json["totalGold"];
    xp = json["xp"];
  }
}

class ChampionStats{
  dynamic abilityHaste = 0;
  dynamic abilityPower = 0;
  dynamic armor = 0;
  dynamic armorPen = 0;
  dynamic armorPenPercent = 0;
  dynamic attackDamage = 0;
  dynamic attackSpeed = 0;
  dynamic bonusArmorPenPercent = 0;
  dynamic bonusMagicPenPercent = 0;
  dynamic ccReduction = 0;
  dynamic coolDownReduction = 0;
  dynamic health = 0;
  dynamic healthMax = 0;
  dynamic healthRegen = 0;
  dynamic lifeSteal = 0;
  dynamic magicPen = 0;
  dynamic magicPenPercent = 0;
  dynamic magicResist = 0;
  dynamic movementSpeed = 0;
  dynamic omniVamp = 0;
  dynamic physicalVamp = 0;
  dynamic power = 0;
  dynamic powerMax = 0;
  dynamic powerRegen = 0;
  dynamic spellVamp = 0;

  ChampionStats();

  ChampionStats.fromJson(Map<String, dynamic> json){
    abilityHaste = json["abilityHaste"];
    abilityPower = json["abilityPower"];
    armor = json["armor"];
    armorPen = json["armorPen"];
    armorPenPercent = json["armorPenPercent"];
    attackDamage = json["attackDamage"];
    attackSpeed = json["attackSpeed"];
    bonusArmorPenPercent = json["bonusArmorPenPercent"];
    bonusMagicPenPercent = json["bonusMagicPenPercent"];
    ccReduction = json["ccReduction"];
    coolDownReduction = json["cooldownReduction"];
    health = json["health"];
    healthMax = json["healthMax"];
    healthRegen = json["healthRegen"];
    lifeSteal = json["lifesteal"];
    magicPen = json["magicPen"];
    magicPenPercent = json["magicPenPercent"];
    magicResist = json["magicResist"];
    movementSpeed = json["movementSpeed"];
    omniVamp = json["omnivamp"];
    physicalVamp = json["physicalVamp"];
    power = json["power"];
    powerMax = json["powerMax"];
    powerRegen = json["powerRegen"];
    spellVamp = json["spellVamp"];
  }
}

class DamageStats {
  dynamic magicDamageDone = 0;
  dynamic magicDamageDoneToChampions = 0;
  dynamic magicDamageTaken = 0;
  dynamic physicalDamageDone = 0;
  dynamic physicalDamageDoneToChampions = 0;
  dynamic physicalDamageTaken = 0;
  dynamic totalDamageDone = 0;
  dynamic totalDamageDoneToChampions = 0;
  dynamic totalDamageTaken = 0;
  dynamic trueDamageDone = 0;
  dynamic trueDamageDoneToChampions = 0;
  dynamic trueDamageTaken = 0;

  DamageStats();

  DamageStats.fromJson(Map<String, dynamic> json){
    magicDamageDone = json["magicDamageDone"];
    magicDamageDoneToChampions = json["magicDamageDoneToChampions"];
    magicDamageTaken = json["magicDamageTaken"];
    physicalDamageDone = json["physicalDamageDone"];
    physicalDamageDoneToChampions = json["physicalDamageDoneToChampions"];
    physicalDamageTaken = json["physicalDamageTaken"];
    totalDamageDone = json["totalDamageDone"];
    totalDamageDoneToChampions = json["totalDamageDoneToChampions"];
    totalDamageTaken = json["totalDamageTaken"];
    trueDamageDone = json["trueDamageDone"];
    trueDamageDoneToChampions = json["trueDamageDoneToChampions"];
    trueDamageTaken = json["trueDamageTaken"];
  }
}

class Position {
  dynamic x = 0;
  dynamic y = 0;

  Position();

  Position.fromJson(Map<String, dynamic> json){
    x = json["x"];
    y = json["y"];
  }

}



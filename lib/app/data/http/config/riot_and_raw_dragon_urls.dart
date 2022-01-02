

abstract class RiotAndRawDragonUrls {
  static const String riotAmericasUrl = "https://americas.api.riotgames.com";
  static const String riotAsiaUrl = "https://asia.api.riotgames.com";
  static const String riotEuropeUrl = "https://europe.api.riotgames.com";
  static const String riotDragonUrl = "https://ddragon.leagueoflegends.com";
  static const String rawDataDragonUrl = "https://raw.communitydragon.org";
  static const String opGGUrl = "https://opgg-static.akamaized.net";
  static const String riotStaticDataUrl = "https://static.developer.riotgames.com";
  static String riotBaseUrl(String region)=> "https://$region.api.riotgames.com";
}

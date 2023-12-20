abstract class API {
  static const String riotAmericasUrl = "https://americas.api.riotgames.com";
  static const String riotAsiaUrl = "https://asia.api.riotgames.com";
  static const String riotEuropeUrl = "https://europe.api.riotgames.com";
  static const String riotDragonUrl = "https://ddragon.leagueoflegends.com";

  /// ENDPOINTS ESTRANGEIROS PARA PEGAR DADOS, COMO: IMAGENS.
  static const String rawDataDragonUrl = "https://raw.communitydragon.org";
  static const String opGGUrl = "https://opgg-static.akamaized.net";

  /// CONSIGO ARQUIVOS ESTÁTICOS POR MEIO DESSE ENDPOINT
  static const String riotStaticDataUrl = "https://static.developer.riotgames.com";

  /// CONFORME A CHAVE QUE RECEBO, O LINK DA REGIÃO MUDA.
  static String riotBaseUrl(String region)=> "https://$region.api.riotgames.com";

}
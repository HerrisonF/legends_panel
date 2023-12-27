enum RegionEndpoints {
  BR1('https://br1.api.riotgames.com'),
  EUN1('https://eun1.api.riotgames.com'),
  EUW1('https://euw1.api.riotgames.com'),
  JP1('https://jp1.api.riotgames.com'),
  KR('https://kr.api.riotgames.com'),
  LA1('https://la1.api.riotgames.com'),
  LA2('https://la2.api.riotgames.com'),
  NA1('https://na1.api.riotgames.com'),
  OC1('https://oc1.api.riotgames.com'),
  TR1('https://tr1.api.riotgames.com'),
  RU('https://ru.api.riotgames.com'),
  PH2('https://ph2.api.riotgames.com'),
  SG2('https://sg2.api.riotgames.com'),
  TH2('https://th2.api.riotgames.com'),
  TW2('https://tw2.api.riotgames.com'),
  VN2('https://vn2.api.riotgames.com');

  final String apiAddress;

  const RegionEndpoints(this.apiAddress);

  static String fromString(String str) {
    try {
      return RegionEndpoints.values
          .firstWhere(
            (element) => element.toString().split('.').last.contains(str),
          ).apiAddress;
    } catch (e) {
      /// Caso a região da pessoa não exista, então retorno por padrão a primeira
      /// url.
      return RegionEndpoints.values.first.apiAddress;
    }
  }

}

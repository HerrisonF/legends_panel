class GameLanguageModel {
  String language;

  GameLanguageModel({
    required this.language,
  });

  String splitRegion(){
    return language.split('-')[1];
  }
}

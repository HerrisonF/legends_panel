class GameLanguageDTO {
  String language;

  GameLanguageDTO({
    required this.language,
  });

  factory GameLanguageDTO.fromJson(String item) {
    return GameLanguageDTO(
      language: item,
    );
  }
}
class GameLanguageDTO {
  String language;

  GameLanguageDTO({
    required this.language,
  });

  Map<String, dynamic> toJson() {
    return {
      'language': language,
    };
  }

  factory GameLanguageDTO.fromJsonLocal(Map<String, dynamic> json) {
    return GameLanguageDTO(
      language: json['language'],
    );
  }

  factory GameLanguageDTO.fromJsonRemote(String item) {
    return GameLanguageDTO(
      language: item,
    );
  }
}
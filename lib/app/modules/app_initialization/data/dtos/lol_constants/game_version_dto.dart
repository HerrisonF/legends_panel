class GameVersionDTO {
  String version;

  GameVersionDTO({
    required this.version,
  });

  factory GameVersionDTO.fromJson(String item) {
    return GameVersionDTO(
      version: item,
    );
  }
}
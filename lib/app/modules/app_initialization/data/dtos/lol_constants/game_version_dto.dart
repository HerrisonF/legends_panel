class GameVersionDTO {
  String version;

  GameVersionDTO({
    required this.version,
  });

  Map<String, dynamic> toJson() {
    return {
      'version': this.version,
    };
  }

  factory GameVersionDTO.fromJsonLocal(Map<String, dynamic> json) {
    return GameVersionDTO(
      version: json['version'],
    );
  }

  factory GameVersionDTO.fromJsonRemote(String item) {
    return GameVersionDTO(
      version: item,
    );
  }
}
class InformationDTO {
  dynamic attack;
  dynamic defense;
  dynamic magic;
  dynamic difficulty;

  InformationDTO({
    required this.attack,
    required this.defense,
    required this.magic,
    required this.difficulty,
  });

  factory InformationDTO.fromJson(Map<String, dynamic> json) {
    return InformationDTO(
      attack: json['attack'] ?? 0,
      defense: json['defense'] ?? 0,
      magic: json['magic'] ?? 0,
      difficulty: json['difficulty'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attack': this.attack,
      'defense': this.defense,
      'magic': this.magic,
      'difficulty': this.difficulty,
    };
  }
}
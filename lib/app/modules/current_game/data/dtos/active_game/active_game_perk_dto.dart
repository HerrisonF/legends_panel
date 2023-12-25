class ActiveGamePerkDTO {
  /// IDs of the perks/runes assigned.
  List<int> perkIds;

  /// Primary runes path
  int perkStyle;

  /// Secondary runes path
  int perkSubStyle;

  ActiveGamePerkDTO({
    required this.perkIds,
    required this.perkStyle,
    required this.perkSubStyle,
  });

  factory ActiveGamePerkDTO.fromJson(Map<String, dynamic> json) {
    return ActiveGamePerkDTO(
      perkIds: json['perkIds'] != null
          ? (json['perkIds'] as List<dynamic>).map<int>((perkId) => perkId).toList()
          : [],
      perkStyle: json['perkStyle'] ?? 0,
      perkSubStyle: json['perkSubStyle'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'perkIds': perkIds.toList(),
      'perkStyle': perkStyle,
      'perkSubStyle': perkSubStyle,
    };
  }
}

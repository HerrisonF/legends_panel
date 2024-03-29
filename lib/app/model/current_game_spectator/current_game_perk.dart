class CurrentGamePerk {
  /// IDs of the perks/runes assigned.
  List<int> perkIds = [];
  /// Primary runes path
  int perkStyle = 0;
  /// Secondary runes path
  int perkSubStyle = 0;

  CurrentGamePerk();

  CurrentGamePerk.fromJson(Map<String, dynamic> json) {
    if (json['perkIds'] != null) {
      json['perkIds'].forEach((perkId) {
        perkIds.add(perkId);
      });
    }
    perkStyle = json['perkStyle'] ?? 0;
    perkSubStyle = json['perkSubStyle'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['perkIds'] = perkIds.toList();
    data['perkStyle'] = perkStyle;
    data['perkSubStyle'] = perkSubStyle;

    return data;
  }

  @override
  String toString() {
    return 'CurrentGamePerk{perkIds: $perkIds, perkStyle: $perkStyle, perkSubStyle: $perkSubStyle}';
  }
}

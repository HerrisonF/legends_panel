class ActiveGamePerkModel {
  /// IDs of the perks/runes assigned.
  List<int> perkIds;

  /// Primary runes path
  int perkStyle;

  /// Secondary runes path
  int perkSubStyle;

  ActiveGamePerkModel({
    required this.perkIds,
    required this.perkStyle,
    required this.perkSubStyle,
  });
}

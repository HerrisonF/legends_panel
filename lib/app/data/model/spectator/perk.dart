class Perk {
  List<int> perkIds = [];
  int perkStyle = 0;
  int perkSubStyle = 0;

  Perk.fromJson(Map<String, dynamic> json) {
    if (json['perkIds'] != null) {
      json['perkIds'].forEach((perkId) {
        perkIds.add(perkId);
      });
    }
    perkStyle = json['perkStyle'];
    perkSubStyle = json['perkSubStyle'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['perkIds'] = perkIds.toList();
    data['perkStyle'] = perkStyle;
    data['perkSubStyle'] = perkSubStyle;

    return data;
  }
}

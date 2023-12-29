class PerkStyleModel {
  int id;
  String key;
  String icon;
  String name;
  List<SlotsModel> slotModels;

  PerkStyleModel({
    required this.id,
    required this.key,
    required this.icon,
    required this.name,
    required this.slotModels,
  });

  factory PerkStyleModel.empty(){
    return PerkStyleModel(
      id: 0,
      key: "",
      icon: "",
      name: "",
      slotModels: [],
    );
  }
}

class SlotsModel {
  List<RuneModel> runeModels = [];

  SlotsModel({
    required this.runeModels,
  });
}

class RuneModel {
  int id;
  String key;
  String icon;
  String name;
  String shortDesc;
  String longDesc;

  RuneModel({
    required this.id,
    required this.key,
    required this.icon,
    required this.name,
    required this.shortDesc,
    required this.longDesc,
  });
}

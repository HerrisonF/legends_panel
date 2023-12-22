import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/image_model.dart';

class ItemModel {
  String? name;
  String? description;
  String? colloq;
  String? plaintext;
  List<String>? into;
  ImageModel? image;
  GoldModel? gold;
  List<String>? tags;
  MapsModel? maps;
  StatsItemModel? stats;

  ItemModel({
    this.name,
    this.description,
    this.colloq,
    this.plaintext,
    this.into,
    this.image,
    this.gold,
    this.tags,
    this.maps,
    this.stats,
  });
}

class GoldModel {
  dynamic base;
  bool? purchasable;
  dynamic total;
  dynamic sell;

  GoldModel({
    this.base,
    this.purchasable,
    this.total,
    this.sell,
  });
}

class MapsModel {
  bool? b11;
  bool? b12;
  bool? b21;
  bool? b22;
  bool? b30;

  MapsModel({
    this.b11,
    this.b12,
    this.b21,
    this.b22,
    this.b30,
  });
}

class StatsItemModel {
  dynamic flatMovementSpeedMod;

  StatsItemModel({
    this.flatMovementSpeedMod,
  });
}

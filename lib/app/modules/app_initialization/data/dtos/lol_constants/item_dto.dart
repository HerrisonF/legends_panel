import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/image_dto.dart';

class ItemDTO {
  String? name;
  String? description;
  String? colloq;
  String? plaintext;
  List<String>? into;
  ImageDTO? image;
  GoldDTO? gold;
  List<String>? tags;
  MapsDTO? maps;
  StatsDTO? stats;

  ItemDTO({
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

  factory ItemDTO.fromJson(Map<String, dynamic> json) {
    return ItemDTO(
      name: json['name'],
      description: json['description'],
      colloq: json['colloq'],
      plaintext: json['plaintext'],
      into: json['into'] != null ? json['into'].cast<String>() : [],
      image:
      json['image'] != null ? new ImageDTO.fromJson(json['image']) : null,
      gold: json['gold'] != null ? new GoldDTO.fromJson(json['gold']) : null,
      tags: json['tags'].cast<String>(),
      maps: json['maps'] != null ? new MapsDTO.fromJson(json['maps']) : null,
      stats:
      json['stats'] != null ? new StatsDTO.fromJson(json['stats']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'description': this.description,
      'colloq': this.colloq,
      'plaintext': this.plaintext,
      'into': this.into,
      'image': this.image!.toJson(),
      'gold': this.gold!.toJson(),
      'tags': this.tags,
      'maps': this.maps!.toJson(),
      'stats': this.stats!.toJson(),
    };
  }
}

class GoldDTO {
  dynamic base;
  bool? purchasable;
  dynamic total;
  dynamic sell;

  GoldDTO({
    this.base,
    this.purchasable,
    this.total,
    this.sell,
  });

  factory GoldDTO.fromJson(Map<String, dynamic> json) {
    return GoldDTO(
      base: json['base'] ?? 0,
      purchasable: json['purchasable'] ?? false,
      total: json['total'] ?? 0,
      sell: json['sell'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base': this.base,
      'purchasable': this.purchasable,
      'total': this.total,
      'sell': this.sell,
    };
  }
}

class MapsDTO {
  bool? b11;
  bool? b12;
  bool? b21;
  bool? b22;
  bool? b30;

  MapsDTO({
    this.b11,
    this.b12,
    this.b21,
    this.b22,
    this.b30,
  });

  factory MapsDTO.fromJson(Map<String, dynamic> json) {
    return MapsDTO(
      b11: json['11'] ?? false,
      b12: json['12'] ?? false,
      b21: json['21'] ?? false,
      b22: json['22'] ?? false,
      b30: json['30'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '11': this.b11,
      '12': this.b12,
      '21': this.b21,
      '22': this.b22,
      '30': this.b30,
    };
  }
}

class StatsDTO {
  dynamic flatMovementSpeedMod;

  StatsDTO({this.flatMovementSpeedMod});

  factory StatsDTO.fromJson(Map<String, dynamic> json) {
    return StatsDTO(
      flatMovementSpeedMod: json['FlatMovementSpeedMod'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FlatMovementSpeedMod': this.flatMovementSpeedMod,
    };
  }
}

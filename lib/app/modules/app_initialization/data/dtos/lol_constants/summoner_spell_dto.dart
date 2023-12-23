import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/image_dto.dart';

class SummonerSpellDTO {
  String id;
  String name;
  String description;
  String tooltip;
  int maxRank;
  String cooldownBurn;
  List<String> effectBurn;
  String key;
  int summonerLevel;
  List<String> modes;
  String maxAmmo;
  String rangeBurn;
  ImageDTO? image;

  SummonerSpellDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.tooltip,
    required this.maxRank,
    required this.cooldownBurn,
    required this.effectBurn,
    required this.key,
    required this.summonerLevel,
    required this.modes,
    required this.maxAmmo,
    required this.rangeBurn,
    required this.image,
  });

  factory SummonerSpellDTO.fromJson(Map<String, dynamic> json) {
    return SummonerSpellDTO(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      key: json['key'] ?? "",
      maxRank: json['maxrank'] ?? 0,
      image: ImageDTO.fromJson(json['image']),
      tooltip: json['tooltip'] ?? "",
      cooldownBurn: json['cooldownBurn'],
      effectBurn: json['effectBurn'] != null
          ? json['effectBurn'].cast<String>()
          : [],
      rangeBurn: json['rangeBurn'] ?? "",
      maxAmmo: json['maxammo'] ?? "",
      modes: json['modes'].cast<String>(),
      summonerLevel: json['summonerLevel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'key': key,
      'image': image!.toJson(),
      'tooltip': tooltip,
      'maxRank': maxRank,
      'rangeBurn': rangeBurn,
      'cooldownBurn' : cooldownBurn,
      'maxammo': maxAmmo,
      'effectBurn': effectBurn.map((e) => e).toList().toString(),
      'modes': modes.map((e) => (e) => e).toList().toString(),
      'summonerLevel': summonerLevel,
    };
  }
}

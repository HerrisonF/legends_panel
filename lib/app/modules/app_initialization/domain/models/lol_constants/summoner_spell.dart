import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/image_model.dart';

class SummonerSpell {
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
  ImageModel? image;

  SummonerSpell({
    required this.id,
    required this.name,
    required this.description,
    required this.tooltip,
    required this.key,
    required this.image,
    required this.effectBurn,
    required this.modes,
    required this.cooldownBurn,
    required this.rangeBurn,
    required this.maxAmmo,
    required this.summonerLevel,
    required this.maxRank,
  });
}

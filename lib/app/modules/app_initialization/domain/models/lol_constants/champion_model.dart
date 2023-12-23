import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_stats_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/image_model.dart';

class ChampionModel {
  String version;
  String id;
  String key;
  String name;
  String title;
  String blurb;
  InformationModel info;
  ImageModel image;
  List<String> tags;
  String partype;
  ChampionStatsModel stats;

  ChampionModel({
    required this.version,
    required this.id,
    required this.key,
    required this.name,
    required this.title,
    required this.blurb,
    required this.info,
    required this.image,
    required this.tags,
    required this.partype,
    required this.stats,
  });
}

class InformationModel {
  dynamic attack;
  dynamic defense;
  dynamic magic;
  dynamic difficulty;

  InformationModel({
    required this.attack,
    required this.defense,
    required this.magic,
    required this.difficulty,
  });

  factory InformationModel.empty() {
    return InformationModel(
      attack: 0,
      defense: 0,
      magic: 0,
      difficulty: 0,
    );
  }
}

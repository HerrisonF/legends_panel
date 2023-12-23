import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/champion_stats_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/image_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/information_dto.dart';

class ChampionDTO {
  String version;
  String id;
  String key;
  String name;
  String title;
  String blurb;
  InformationDTO? info;
  ImageDTO? image;
  List<String> tags;
  String partype;
  ChampionStatsDTO? stats;

  ChampionDTO({
    required this.version,
    required this.id,
    required this.key,
    required this.name,
    required this.title,
    required this.stats,
    required this.partype,
    required this.image,
    required this.info,
    required this.blurb,
    required this.tags,
  });

  factory ChampionDTO.fromJson(Map<String, dynamic> json) {
    return ChampionDTO(
      version: json['version'] ?? "",
      id: json['id'] ?? "",
      key: json['key'] ?? "",
      name: json['name'] ?? "",
      title: json['title'] ?? "",
      blurb: json['blurb'] ?? "",
      info: json['info'] != null ? InformationDTO.fromJson(json['info']) : null,
      image: json['image'] != null ? ImageDTO.fromJson(json['image']) : null,
      tags: json['tags'] != null ? json['tags'].cast<String>() : [],
      partype: json['partype'] ?? "",
      stats: json['stats'] != null ? ChampionStatsDTO.fromJson(json['stats']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': this.version,
      'id': this.id,
      'key': this.key,
      'name': this.name,
      'title': this.title,
      'blurb': this.blurb,
      'info': this.info?.toJson(),
      'image': this.image?.toJson(),
      'tags': this.tags,
      'partype': this.partype,
      'stats': this.stats?.toJson(),
    };
  }
}

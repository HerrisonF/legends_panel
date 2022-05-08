import 'package:legends_panel/app/layers/domain/entities/lol_version/lol_version_entity.dart';

class LolVersionDto extends LolVersionEntity{

  List<String> versions;

  LolVersionDto({required this.versions}) : super(versions: versions);

  toJson() => {
    'versions' : versions.map((e) => e.toString()).toList(),
  };

  static LolVersionDto fromJson(List<dynamic> map) {
    List<String> versions = [];
    map.forEach((value) {
      versions.add(value.toString());
    });
   return LolVersionDto(versions: versions);
  }

  static LolVersionDto fromLocalJson(Map<String, dynamic> json) {
    List<String> versions = [];
    json['versions'].forEach((value) {
      versions.add(value.toString());
    });
    return LolVersionDto(versions: versions);
  }
}
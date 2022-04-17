import 'package:legends_panel/app/layers/domain/entities/lol_version/lol_version_entity.dart';

class LolVersionDto extends LolVersionEntity{

  List<String> versions;

  LolVersionDto({required this.versions}) : super(versions: versions);

  toMap() => {
    'versions' : versions.map((e) => e.toString()).toList(),
  };

  static LolVersionDto fromMap(List<dynamic> map) {
    List<String> versions = [];
    map.forEach((value) {
      versions.add(value.toString());
    });
   return LolVersionDto(versions: versions);
  }
}
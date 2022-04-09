import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';

class LolVersionDto extends LolVersionEntity{

  //Esse é o cara que sempre irá fazer a interface entre o que tem na nuvem e a
  //entidade

  List<String> versions;

  LolVersionDto({required this.versions}) : super(versions: versions);

  toMap() => {
    'versions' : versions.map((e) => e).toList(),
  };

  LolVersionDto fromMap(Map map) {
    List<String> versions = [];
    map.forEach((key, value) {
      versions.add(value);
    });
   return LolVersionDto(versions: versions);
  }
}
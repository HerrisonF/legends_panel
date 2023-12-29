class PerkStyleDTO {
  int id;
  String key;
  String icon;
  String name;
  List<SlotsDTO> slotsDTO;

  PerkStyleDTO({
    required this.id,
    required this.key,
    required this.icon,
    required this.name,
    required this.slotsDTO,
  });

  factory PerkStyleDTO.fromJson(Map<String, dynamic> json) {
    return PerkStyleDTO(
      id: json['id'] ?? 0,
      key: json['key'] ?? "",
      icon: json['icon'] ?? "",
      name: json['name'] ?? "",
      slotsDTO: json['slots'] != null
          ? (json['slots'] as List)
          .map<SlotsDTO>((element) => SlotsDTO.fromJson(element))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'icon': icon,
      'name': name,
      'slots': slotsDTO.map((e) => e.toJson()).toList(),
    };
  }
}

class SlotsDTO {
  List<RuneDTO> runeDTOs = [];

  SlotsDTO({
    required this.runeDTOs,
  });

  SlotsDTO.fromJson(Map<String, dynamic> json) {
    if (json['runes'] != null) {
      json['runes'].forEach((element) {
        runeDTOs.add(RuneDTO.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'runes': runeDTOs.map((e) => e.toJson()).toList(),
    };
  }
}

class RuneDTO {
  int id;
  String key;
  String icon;
  String name;
  String shortDesc;
  String longDesc;

  RuneDTO({
    required this.id,
    required this.key,
    required this.icon,
    required this.name,
    required this.shortDesc,
    required this.longDesc,
  });

  factory RuneDTO.fromJson(Map<String, dynamic> json) {
    return RuneDTO(
      id: json['id'] ?? 0,
      key: json['key'] ?? "",
      icon : json['icon'] ?? "",
      name: json['name'] ?? "",
      shortDesc: json['shortDesc'] ?? "",
      longDesc: json['longDesc'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'icon': icon,
      'name': name,
      'shortDesc': shortDesc,
      'longDesc': longDesc,
    };
  }
}

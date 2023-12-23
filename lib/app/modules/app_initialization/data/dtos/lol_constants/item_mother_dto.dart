import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/group_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/item_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/tree_dto.dart';

class ItemMotherDTO {
  List<ItemDTO> items;
  List<GroupDTO> groups;
  List<TreeDTO> trees;

  ItemMotherDTO({
    required this.items,
    required this.groups,
    required this.trees,
  });

  factory ItemMotherDTO.fromJson(Map<String, dynamic> json) {
    return ItemMotherDTO(
      items: json['items'].map<ItemDTO>((e) => ItemDTO.fromJson(e)).toList(),
      groups: json['groups'].map<GroupDTO>((e) => GroupDTO.fromJson(e)).toList(),
      trees: json['trees'].map<TreeDTO>((e) => TreeDTO.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'groups': groups.map((e) => e.toJson()).toList(),
      'trees': trees.map((e) => e.toJson()).toList(),
    };
  }
}

import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/group_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/item_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/tree_model.dart';

/// Esse nome e modelo é para sintetizar todos os dados dos itens e demais
/// atributos que podem ser úteis.
class ItemMotherModel {
  List<ItemModel> items;
  List<GroupModel> groups;
  List<TreeModel> trees;

  ItemMotherModel({
    required this.items,
    required this.groups,
    required this.trees,
  });
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/build_page_controller/build_page_controller.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'champion_build_bottom_sheet.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({Key? key}) : super(key: key);

  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  final BuildPageController _buildPageController =
      Get.put(BuildPageController());

  final MasterController _masterController = Get.find<MasterController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _buildPageController.init(_masterController.championRoom);
    super.initState();
  }

  @override
  void dispose() {
    _buildPageController.searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          _screenMessage(),
          _searchField(),
          _championList(),
        ],
      ),
    );
  }

  _screenMessage() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Text(
            AppLocalizations.of(context)!.buildPageTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  _searchField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: TextFormField(
        controller: _buildPageController.searchEditingController,
        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.championName),
        onChanged: (value) {
          _buildPageController.showChampionEqualsFromSearch(value);
        },
      ),
    );
  }

  _championList() {
    return Expanded(
      child: Obx(() {
        return GridView.builder(
          padding: EdgeInsets.zero,
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: hasMoreLoadings(),
          itemBuilder: (_, index) {
            return championImageOrLoading(index);
          },
        );
      }),
    );
  }

  int hasMoreLoadings() {
    if (_buildPageController.isLoading.value) {
      return _buildPageController.searchedChampion.length + 1;
    }
    return _buildPageController.searchedChampion.length;
  }

  championImageOrLoading(int index) {
    return InkWell(
      onTap: () {
        _buildPageController.cleanSearch();
        _openBottomSheet(
            _buildPageController.searchedChampion[index].detail.key, _buildPageController.searchedChampion[index].detail.name);
      },
      child: Column(
        children: [
          _buildPageController
                  .getChampionImage(
                    _buildPageController.searchedChampion[index].detail.id,
                  )
                  .isNotEmpty
              ? Image.network(
                  _buildPageController.getChampionImage(
                    _buildPageController.searchedChampion[index].detail.id,
                  ),
                  width: MediaQuery.of(context).size.width / 10,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  imageIconItemNone,
                  width: MediaQuery.of(context).size.width / 10,
                  fit: BoxFit.cover,
                ),
          Container(
            child: Text(
              _buildPageController.searchedChampion[index].detail.name,
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  _openBottomSheet(String championKey, String championName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ChampionBuildBottomSheet(championId: championKey, championName: championName,);
      },
    );
  }
}

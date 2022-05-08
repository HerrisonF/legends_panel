import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/core/data/services/dio_http_service_imp.dart';
import 'package:legends_panel/app/decorators/lol_version_decorator/lol_version_cache_repository_decorator.dart';
import 'package:legends_panel/app/layers/data/datasources/contracts/lol_version_datasources/get_lol_version_datasource.dart';
import 'package:legends_panel/app/layers/data/datasources/remote_imp/lol_version/get_lol_version_remote_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version/lol_version_dto.dart';
import 'package:legends_panel/app/layers/data/repositories/lol_version_repositories/get_lol_version_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version/lol_version_entity.dart';
import 'package:legends_panel/app/layers/domain/repositories/lol_version/get_lol_version_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  GetLolVersionDataSource dataSource =
      GetLolVersionRemoteDataSourceImp(DioHttpServiceImp());
  GetLolVersionRepository repository = GetLolVersionRepositoryImp(dataSource);
  LolVersionCacheRepositoryDecorator decorator =
      LolVersionCacheRepositoryDecorator(repository);

  test('Should return versions', () async {
    var result = await decorator();
    late LolVersionEntity resultExpect;
    result.fold((l) => null, (r) => resultExpect = r);
    expect(resultExpect.versions, isNotEmpty);
  });

  test('Should return versions without Internet', () async {
    late LolVersionDto resultExpect;
    try{
      SharedPreferences.setMockInitialValues({});
      var prefs = await SharedPreferences.getInstance();
      LolVersionDto lolVersionDto = LolVersionDto(
        versions: [
          "12.1",
          "12.0",
          "11.0"
        ],
      );
      String temp = jsonEncode(lolVersionDto.toJson());
      prefs.setString("lol_version", temp);
      var lolVersionString = prefs.getString("lol_version");
      if(lolVersionString != null){
        Map<String, dynamic> lolVersions = jsonDecode(lolVersionString);
        resultExpect = LolVersionDto.fromLocalJson(lolVersions);
      }
    }catch(e){
      print(e);
    }
    expect(resultExpect.versions.isNotEmpty, true);
  });
}

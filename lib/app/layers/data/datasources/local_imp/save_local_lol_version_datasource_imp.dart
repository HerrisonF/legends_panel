// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version/lol_version_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contracts/lol_version_datasources/save_lol_version_datasource.dart';


class SaveLocalLolVersionDataSourceImp implements SaveLolVersionDataSource {

  @override
  Future<Either<Exception, bool>> call(LolVersionDto lolVersionDto) async {
    try{
      SharedPreferences.setMockInitialValues({});
      var prefs = await SharedPreferences.getInstance();
      String jsonLolVersion = jsonEncode(lolVersionDto.toMap());
      prefs.setString('lolVersion_cache', jsonLolVersion);
      print('salvou no cache ');
      return Right(true);
    }catch(e){
      print('Erro ao salvar no cache');
      return Left(Exception('Erro ao salvar no cache'));
    }
  }

}
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/decorators/lol_version_repository_decorator.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version_dto.dart';
import 'package:legends_panel/app/layers/domain/repositories/get_lol_version_repository.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LolVersionCacheRepositoryDecorator extends LolVersionRepositoryDecorator {
  LolVersionCacheRepositoryDecorator(
      GetLolVersionRepository getLolVersionRepository)
      : super(getLolVersionRepository);

  static const _LOL_VERSION_KEY = 'lol_version';
  final Logger log = Logger('LOL_VERSION_DECORATOR');

  @override
  Future<Either<Exception, LolVersionDto>> call() async {
    return (await super.call()).fold(
      (error) async => await _getInCache(),
      (result) {
        _saveInCache(result);
        return Right(result);
      },
    );
  }

  _saveInCache(LolVersionDto lolVersionDto) async {
    try {
      SharedPreferences.setMockInitialValues({});
      var prefs = await SharedPreferences.getInstance();
      String jsonLolVersion = jsonEncode(lolVersionDto.toMap());
      prefs.setString(_LOL_VERSION_KEY, jsonLolVersion);
      log.fine('Versão salva com sucesso !');
    } catch (e) {
      log.severe('Erro ao salvar a versão do lol em cache');
    }
  }

  Future<Either<Exception, LolVersionDto>> _getInCache() async {
    try {
      SharedPreferences.setMockInitialValues({});
      var prefs = await SharedPreferences.getInstance();
      var jsonLolVersion = prefs.getString(_LOL_VERSION_KEY);
      List<dynamic> json = jsonDecode(jsonLolVersion!);
      log.warning('Versão do lol foi pego do cache');
      return Right(LolVersionDto.fromMap(json));
    } catch (e) {
      log.severe('Erro ao pegar a versão do lol em cache.');
      return Left(Exception('Erro ao pegar a versão do lol em cache.'));
    }
  }
}

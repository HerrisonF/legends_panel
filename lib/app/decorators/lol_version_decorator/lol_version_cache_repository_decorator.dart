import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/decorators/lol_version_decorator/lol_version_repository_decorator.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version/lol_version_dto.dart';
import 'package:legends_panel/app/layers/domain/repositories/lol_version/get_lol_version_repository.dart';
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
      var prefs = await SharedPreferences.getInstance();
      String jsonLolVersion = jsonEncode(lolVersionDto.toJson());
      if(await prefs.setString(_LOL_VERSION_KEY, jsonLolVersion)){
        log.fine('Versão salva com sucesso !');
      }else{
        log.severe("Problemas ao salvar a versão.");
      }
    } catch (e) {
      log.severe('Erro ao salvar a versão do lol em cache: ${e.toString()}');
    }
  }

  Future<Either<Exception, LolVersionDto>> _getInCache() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var jsonLolVersion = prefs.getString(_LOL_VERSION_KEY);
      if(jsonLolVersion != null){
        Map<String, dynamic> lolVersions = jsonDecode(jsonLolVersion);
        log.fine('Versão do lol foi pego do cache');
        return Right(LolVersionDto.fromLocalJson(lolVersions));
      }else{
        log.warning('Cache de versões do lol esta vazio.');
        return Left(Exception('Cache de versões do lol esta vazio.'));
      }
    } catch (e) {
      log.severe('Erro ao pegar a versão do lol em cache.');
      return Left(Exception('Erro ao pegar a versão do lol em cache.'));
    }
  }
}

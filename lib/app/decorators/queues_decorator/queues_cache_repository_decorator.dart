import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/decorators/queues_decorator/queues_repository_decorator.dart';
import 'package:legends_panel/app/layers/domain/repositories/queue/get_queues_repository.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../layers/data/dtos/queue/queue_wrapper_dto.dart';

class QueuesCacheRepositoryDecorator extends QueuesRepositoryDecorator {
  QueuesCacheRepositoryDecorator(GetQueuesRepository getQueuesRepository)
      : super(getQueuesRepository);

  static const _QUEUE_VERSION_KEY = "queue";
  final Logger log = Logger("QUEUE_DECORATOR");

  @override
  Future<Either<Exception, QueueWrapperDto>> call() async {
    return (await super.call()).fold(
      (error) async => await _getInCache(),
      (result) {
        _saveInCache(result);
        return Right(result);
      },
    );
  }

  _saveInCache(QueueWrapperDto queueWrapperDto) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String jsonQueue = jsonEncode(queueWrapperDto.toJson());
      if(await prefs.setString(_QUEUE_VERSION_KEY, jsonQueue)){
        log.fine("Queue salva com sucesso.");
      }else{
        log.severe("Problemas ao salvar as queues em cache");
      }
    } catch (e) {
      log.severe("Erro ao salvar as queues em cache: ${e.toString()}");
    }
  }

  Future<Either<Exception, QueueWrapperDto>> _getInCache() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var jsonQueue = prefs.getString(_QUEUE_VERSION_KEY);
      if (jsonQueue != null) {
        dynamic queues = jsonDecode(jsonQueue);
        log.warning("As queues foram pegas do cache.");
        return Right(QueueWrapperDto.fromLocalJson(queues));
      } else {
        return Left(Exception("O cache de queues está vazio"));
      }
    } catch (e) {
      log.severe("Erro ao pegar as queues em cache: ${e.toString()}");
      return Left(Exception("Erro ao pegar as queues em cache"));
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/layers/domain/entities/queue/queue_entity.dart';

main() {
  test('Should queue not be null', () {
    QueueEntity queueEntity = QueueEntity(
      queueId: 325,
      map: 'Summoner\'s Rift',
      description: 'All Random games',
      notes: '',
    );
    expect(queueEntity, isNotNull);
  });

  test('Should queue notes be null', () {
    QueueEntity queueEntity = QueueEntity(
      queueId: 325,
      map: 'Summoner\'s Rift',
      description: 'All Random games',
      notes: '',
    );
    expect(queueEntity.notes, isEmpty);
  });

  test('Should queue description be null', () {
    QueueEntity queueEntity = QueueEntity(
      queueId: 325,
      map: 'Summoner\'s Rift',
      description: '',
      notes: 'Game mode deprecated',
    );
    expect(queueEntity.description, isEmpty);
  });

  test('Should queue id be an integer 325', () {
    QueueEntity queueEntity = QueueEntity(
      queueId: 325,
      map: 'Summoner\'s Rift',
      description: '',
      notes: 'Game mode deprecated',
    );
    expect(queueEntity.queueId, 325);
  });

  test('Should queue map String be readable and Equals to Summoner\'s Rift', () {
    QueueEntity queueEntity = QueueEntity(
      queueId: 325,
      map: 'Summoner\'s Rift',
      description: '',
      notes: 'Game mode deprecated',
    );
    expect(queueEntity.map, 'Summoner\'s Rift');
  });

  test('Should return empty description', () {
    QueueEntity queueEntity = QueueEntity(
      queueId: 325,
      map: 'Summoner\'s Rift',
      description: '',
      notes: 'Game mode deprecated',
    );
    expect(queueEntity.getQueueDescriptionWithoutGamesString(), isEmpty);
  });

  test('Should return a description without games String', () {
    QueueEntity queueEntity = QueueEntity(
      queueId: 325,
      map: 'Summoner\'s Rift',
      description: '5v5 Ranked Solo games',
      notes: 'Game mode deprecated',
    );
    expect(queueEntity.getQueueDescriptionWithoutGamesString(), '5v5 Ranked Solo');
  });
}

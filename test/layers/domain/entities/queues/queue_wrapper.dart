import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/layers/domain/entities/queue/queue_entity.dart';
import 'package:legends_panel/app/layers/domain/entities/queue/queue_wrapper.dart';

main() {
  test('Should return is not empty', () async {
    QueueWrapper wrapper = QueueWrapper(
      queues: [
        QueueEntity(
          queueId: 2,
          map: 'Custom Games',
          description: '',
          notes: '',
        ),
      ],
    );

    expect(wrapper.hasQueues(), true);
  });

  test('Should return is empty', () async {
    QueueWrapper wrapper = QueueWrapper(queues: []);

    expect(wrapper.hasQueues(), false);
  });
}

class QueueModel {
  int queueId;
  String map;
  String description;
  String notes;

  QueueModel({
    required this.queueId,
    required this.map,
    required this.description,
    required this.notes,
  });

  String getQueueDescriptionWithoutGamesString(){
    if(description.isNotEmpty){
      String result =  description.replaceAll('5v5', '');
      String result2 =  result.replaceAll('games', '');
      String result3 = result2.replaceFirst(new RegExp(r"\s+$"), "");
      return result3;
    }
    return description;
  }
}

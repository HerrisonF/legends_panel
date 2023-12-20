class QueueEntity {
  int queueId;
  String map;
  String description;
  String notes;

  QueueEntity({
    required this.queueId,
    required this.map,
    required this.description,
    required this.notes,
  });

  String getQueueDescriptionWithoutGamesString(){
    if(description.isNotEmpty){
      String result =  description.replaceAll('games', ' ');
      String result2 = result.replaceFirst(new RegExp(r"\s+$"), "");
      return result2;
    }
    return description;
  }
}

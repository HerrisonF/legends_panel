class LolVersionEntity {

  List<String> versions;

  LolVersionEntity({
    required this.versions,
  });

  getLatestVersion(){
    if(versions.isNotEmpty){
      versions.first;
    }
  }

}

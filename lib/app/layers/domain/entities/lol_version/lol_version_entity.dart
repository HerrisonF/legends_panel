class LolVersionEntity {
  List<String> versions;

  LolVersionEntity({required this.versions});

  String getLatestVersion() {
    if (hasVersions()) {
      return versions.first;
    }
    return 'Version not found';
  }

  bool hasVersions() {
    return versions.isNotEmpty;
  }
}

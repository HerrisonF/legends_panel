class TreeDTO {
  String? header;
  List<String>? tags;

  TreeDTO({
    this.header,
    this.tags,
  });

  factory TreeDTO.fromJson(Map<String, dynamic> json) {
    return TreeDTO(
        header: json['header'] ?? "",
        tags: json['tags'] != null ? json['tags'].cast<String>() : []);
  }

  Map<String, dynamic> toJson() {
    return {
      'header': this.header,
      'tags': this.tags,
    };
  }
}

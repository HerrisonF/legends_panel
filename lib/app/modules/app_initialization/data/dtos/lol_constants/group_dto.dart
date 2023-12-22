class GroupDTO {
  String id;

  GroupDTO({
    required this.id,
  });

  factory GroupDTO.fromJson(Map<String, dynamic> json) {
    return GroupDTO(
      id: json['id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
    };
  }
}

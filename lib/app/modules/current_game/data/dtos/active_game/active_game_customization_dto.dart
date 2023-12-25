class ActiveGameCustomizationDTO {
  /// Category identifier for Game Customization
  String category;

  /// Game Customization content
  String content;

  ActiveGameCustomizationDTO({
    required this.category,
    required this.content,
  });

  factory ActiveGameCustomizationDTO.fromJson(Map<String, dynamic> json) {
    return ActiveGameCustomizationDTO(
      category: json['category'] ?? "",
      content: json['content'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'content': content,
    };
  }
}

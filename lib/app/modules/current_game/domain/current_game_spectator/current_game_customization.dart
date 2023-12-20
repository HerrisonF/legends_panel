class CurrentGameCustomization {
  /// Category identifier for Game Customization
  String category = "";
  /// Game Customization content
  String content = "";

  CurrentGameCustomization();

  CurrentGameCustomization.fromJson(Map<String, dynamic> json) {
    category = json['category'] ?? "";
    content = json['content'] ?? "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['category'] = category;
    data['content'] = content;

    return data;
  }

  @override
  String toString() {
    return 'CurrentGameCustomization{category: $category, content: $content}';
  }
}

class ImageDTO {
  String full;
  String sprite;
  String group;
  dynamic x;
  dynamic y;
  dynamic w;
  dynamic h;

  ImageDTO({
    required this.full,
    required this.sprite,
    required this.group,
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });

  factory ImageDTO.fromJson(Map<String, dynamic> json) {
    return ImageDTO(
      full: json['full'] ?? "",
      sprite: json['sprite'] ?? "",
      group: json['group'] ?? "",
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
      w: json['w'] ?? 0,
      h: json['h'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full': this.full,
      'sprite': this.sprite,
      'group': this.group,
      'x': this.x,
      'y': this.y,
      'w': this.w,
      'h': this.h,
    };
  }
}
class ImageModel {
  String full;
  String sprite;
  String group;
  dynamic x;
  dynamic y;
  dynamic w;
  dynamic h;

  ImageModel({
    this.full = "",
    this.sprite = "",
    this.group = "",
    this.x = 0,
    this.y = 0,
    this.w = 0,
    this.h = 0,
  });

  factory ImageModel.empty() {
    return ImageModel(
      y: 0,
      x: 0,
      w: 0,
      sprite: "",
      h: 0,
      group: "",
      full: "",
    );
  }
}
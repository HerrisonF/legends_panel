import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/image_dto.dart';

class ProfileIconDTO {
  int id;
  ImageDTO imageDTO;

  ProfileIconDTO({
    required this.id,
    required this.imageDTO,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': imageDTO.toJson(),
    };
  }

  factory ProfileIconDTO.fromJson(Map<String, dynamic> json) {
    return ProfileIconDTO(
      id: json['id'] ?? 0,
      imageDTO: ImageDTO.fromJson(json['image']),
    );
  }
}

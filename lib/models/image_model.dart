import 'dart:convert';

class ImageModel {
  final double aspectRatio;
  final String filePath;
  final int height;
  final int width;
  ImageModel({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.width,
  });

  ImageModel copyWith({
    double? aspectRatio,
    String? filePath,
    int? height,
    int? width,
  }) {
    return ImageModel(
      aspectRatio: aspectRatio ?? this.aspectRatio,
      filePath: filePath ?? this.filePath,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      aspectRatio: map['aspect_ratio']?.toDouble() ?? 0.0,
      filePath: map['file_path'] ?? '',
      height: map['height']?.toInt() ?? 0,
      width: map['width']?.toInt() ?? 0,
    );
  }

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageModel(aspectRatio: $aspectRatio, filePath: $filePath, height: $height, width: $width)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageModel &&
        other.aspectRatio == aspectRatio &&
        other.filePath == filePath &&
        other.height == height &&
        other.width == width;
  }

  @override
  int get hashCode {
    return aspectRatio.hashCode ^
        filePath.hashCode ^
        height.hashCode ^
        width.hashCode;
  }
}

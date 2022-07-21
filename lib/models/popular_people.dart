import 'dart:convert';

class PopularPeople {
  String name;
  String profilePath;
  int id;
  double popularity;
  PopularPeople({
    required this.name,
    required this.profilePath,
    required this.id,
    required this.popularity,
  });

  PopularPeople copyWith({
    String? name,
    String? profilePath,
    int? id,
    double? popularity,
  }) {
    return PopularPeople(
      name: name ?? this.name,
      profilePath: profilePath ?? this.profilePath,
      id: id ?? this.id,
      popularity: popularity ?? this.popularity,
    );
  }

  factory PopularPeople.fromMap(Map<String, dynamic> map) {
    return PopularPeople(
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      id: map['id']?.toInt() ?? 0,
      popularity: map['popularity']?.toDouble() ?? 0.0,
    );
  }

  factory PopularPeople.fromJson(String source) =>
      PopularPeople.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PopularPeople(name: $name, profilePath: $profilePath, id: $id, popularity: $popularity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PopularPeople &&
        other.name == name &&
        other.profilePath == profilePath &&
        other.id == id &&
        other.popularity == popularity;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePath.hashCode ^
        id.hashCode ^
        popularity.hashCode;
  }
}

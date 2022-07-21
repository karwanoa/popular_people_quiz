import 'dart:convert';

import 'package:hive/hive.dart';

part 'one_person.g.dart';

@HiveType(typeId: 0)
class OnePersonDetails {
  @HiveField(0)
  final String birthday;
  @HiveField(1)
  final String knownForDepartment;
  @HiveField(2)
  final String biography;
  @HiveField(3)
  final String placeOfBirth;
  OnePersonDetails({
    required this.birthday,
    required this.knownForDepartment,
    required this.biography,
    required this.placeOfBirth,
  });

  OnePersonDetails copyWith({
    String? birthday,
    String? knownForDepartment,
    String? biography,
    String? placeOfBirth,
  }) {
    return OnePersonDetails(
      birthday: birthday ?? this.birthday,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      biography: biography ?? this.biography,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
    );
  }

  factory OnePersonDetails.fromMap(Map<String, dynamic> map) {
    return OnePersonDetails(
      birthday: map['birthday'] ?? '',
      knownForDepartment: map['known_for_department'] ?? '',
      biography: map['biography'] ?? '',
      placeOfBirth: map['place_of_birth'] ?? '',
    );
  }

  factory OnePersonDetails.fromJson(String source) =>
      OnePersonDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OnePersonDetails(birthday: $birthday, knownForDepartment: $knownForDepartment, biography: $biography, placeOfBirth: $placeOfBirth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnePersonDetails &&
        other.birthday == birthday &&
        other.knownForDepartment == knownForDepartment &&
        other.biography == biography &&
        other.placeOfBirth == placeOfBirth;
  }

  @override
  int get hashCode {
    return birthday.hashCode ^
        knownForDepartment.hashCode ^
        biography.hashCode ^
        placeOfBirth.hashCode;
  }
}

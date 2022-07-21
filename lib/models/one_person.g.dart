// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnePersonDetailsAdapter extends TypeAdapter<OnePersonDetails> {
  @override
  final int typeId = 0;

  @override
  OnePersonDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnePersonDetails(
      birthday: fields[0] as String,
      knownForDepartment: fields[1] as String,
      biography: fields[2] as String,
      placeOfBirth: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OnePersonDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.birthday)
      ..writeByte(1)
      ..write(obj.knownForDepartment)
      ..writeByte(2)
      ..write(obj.biography)
      ..writeByte(3)
      ..write(obj.placeOfBirth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnePersonDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

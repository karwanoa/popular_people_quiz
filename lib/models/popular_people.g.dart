// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_people.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PopularPeopleAdapter extends TypeAdapter<PopularPeople> {
  @override
  final int typeId = 1;

  @override
  PopularPeople read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PopularPeople(
      name: fields[0] as String,
      profilePath: fields[1] as String,
      id: fields[2] as int,
      popularity: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PopularPeople obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.profilePath)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.popularity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PopularPeopleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

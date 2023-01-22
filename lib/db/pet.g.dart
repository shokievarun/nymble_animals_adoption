// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalModelAdapter extends TypeAdapter<AnimalModel> {
  @override
  final int typeId = 3;

  @override
  AnimalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnimalModel(
      id: fields[0] as int,
      adoptedDate: fields[1] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      imagePath: fields[4] as String,
      sex: fields[5] as String,
      age: fields[6] as double,
      weight: fields[7] as double,
      category: fields[10] as String,
      isAdopted: fields[8] as bool,
      price: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AnimalModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.adoptedDate)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.sex)
      ..writeByte(6)
      ..write(obj.age)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.isAdopted)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

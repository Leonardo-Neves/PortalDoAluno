// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 0;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..ra = fields[2] as String?
      ..birthday = fields[3] as String?
      ..cpf = fields[4] as String?
      ..adress = fields[5] as String?
      ..rg = fields[6] as String?
      ..course = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.ra)
      ..writeByte(3)
      ..write(obj.birthday)
      ..writeByte(4)
      ..write(obj.cpf)
      ..writeByte(5)
      ..write(obj.adress)
      ..writeByte(6)
      ..write(obj.rg)
      ..writeByte(7)
      ..write(obj.course);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

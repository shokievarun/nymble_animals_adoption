import 'package:hive/hive.dart';
export 'package:animals_adoption_flutter/enums/category_enum.dart';
part 'pet.g.dart';

@HiveType(typeId: 3)
class AnimalModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String adoptedDate;
  @HiveField(2)
  String name;
  @HiveField(3)
  String description;
  @HiveField(4)
  String imagePath;
  @HiveField(5)
  String sex;
  @HiveField(6)
  double age;
  @HiveField(7)
  double weight;
  @HiveField(8)
  bool isAdopted;
  @HiveField(9)
  int price;
  @HiveField(10)
  String category;

  AnimalModel(
      {required this.id,
      required this.adoptedDate,
      required this.name,
      required this.description,
      required this.imagePath,
      required this.sex,
      required this.age,
      required this.weight,
      required this.category,
      required this.isAdopted,
      required this.price});
}

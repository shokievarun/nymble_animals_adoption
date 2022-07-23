import 'package:animals_adoption_flutter/enums/category_enum.dart';
import 'package:animals_adoption_flutter/models/model_base.dart';
export 'package:animals_adoption_flutter/enums/category_enum.dart';

class AnimalModel extends ModelBase{

  Category category;

  String name;
  String description;
  String imagePath;
  String location;
  String sex;
  double age;
  double weight;
  double distanceInKm;


  AnimalModel({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.location,
    required this.distanceInKm,
    required this.sex,
    required this.age,
    required this.weight,
    required this.category
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  Map<String, Object?> get dataToShow => {
    'Sex'    : sex,
    'Age'    : age,
    'Weight' : weight
  };

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
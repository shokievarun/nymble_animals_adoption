import 'package:animals_adoption_flutter/enums/category_enum.dart';
import 'package:animals_adoption_flutter/models/model_base.dart';
export 'package:animals_adoption_flutter/enums/category_enum.dart';

class AnimalModel extends ModelBase{

  Category category;

  String name;
  String description;
  String imagePath;
  String location;
  double distanceInKm;


  AnimalModel({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.location,
    required this.distanceInKm,
    required this.category
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
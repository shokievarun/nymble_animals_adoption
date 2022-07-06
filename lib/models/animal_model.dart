


import 'package:animals_adoption_flutter/models/model_base.dart';

class AnimalModel extends ModelBase{

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
    required this.distanceInKm
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
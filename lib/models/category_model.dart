import 'package:animals_adoption_flutter/models/model_base.dart';

class CategoryModel extends ModelBase{


  String name;
  String description;
  String imagePath;

  CategoryModel({
    required this.name,
    required this.description,
    required this.imagePath
  });

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => throw UnimplementedError();

}
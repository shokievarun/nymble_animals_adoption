import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/models/model_base.dart';

class CategoryModel extends ModelBase{

  Category category;

  String description;
  String imagePath;

  String get name => '${category.name[0].toUpperCase()}${category.name.substring(1)}';

  CategoryModel({
    required this.category,
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
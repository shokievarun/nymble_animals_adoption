import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/db/hive_db.dart';
import 'package:animals_adoption_flutter/db/pet.dart';
import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  bool isFromHistory;
  CategoriesBloc(this.isFromHistory) : super(const CategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      // ! implement api

      try {
        emit(const CategoriesLoading());
        List<AnimalModel> listOfAnimals = HiveDB.getData(isFromHistory);
        List<AnimalModel> animalsOfSelectedCategory = listOfAnimals;
        // .where((a) => a.category == categories[1].name.toLowerCase())
        // .toList();

        emit(CategoriesLoaded(
            categories: categories,
            index: 1,
            animals: animalsOfSelectedCategory));
      } on Exception {
        emit(const CategoriesError(message: 'Error getting data.'));
      }
    });

    on<OnCategorySelected>((event, emit) async {
      try {
        List<AnimalModel> listOfAnimals = HiveDB.getData(isFromHistory);
        List<AnimalModel> animalsOfSelectedCategory = listOfAnimals;
        // .where((a) => a.category == event.category.category.toLowerCase())
        // .toList();
        // if (animalModelBox != null) {
        //   animalsOfSelectedCategory = HiveDB.getAnimalModelsList();
        //   animalsOfSelectedCategory = animalsOfSelectedCategory
        //       .where((a) => a.category == event.category.category.toLowerCase())
        //       .toList();
        //   if (animalsOfSelectedCategory.isEmpty) {
        //     animalsOfSelectedCategory = animals
        //         .where(
        //             (a) => a.category == event.category.category.toLowerCase())
        //         .toList();

        //     for (var e in animals) {
        //       HiveDB.addAnimalModel(e);
        //     }
        //   }
        // } else {
        //   animalsOfSelectedCategory = animals
        //       .where((a) => a.category == event.category.category.toLowerCase())
        //       .toList();
        //   for (var e in animals) {
        //     HiveDB.addAnimalModel(e);
        //   }
        // }
        emit(CategoriesLoaded(
            categories: categories,
            index: event.index,
            animals: animalsOfSelectedCategory));
      } on Exception {
        emit(const CategoriesError(message: 'Error getting data.'));
      }
    });
  }
}

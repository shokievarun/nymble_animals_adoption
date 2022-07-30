import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesInitial()) {
    on<GetCategories>((event, emit) async{
      
      // ! implement api 

      try{
        emit(const CategoriesLoading());
        await Future.delayed(const Duration(seconds: 2));
        final List<AnimalModel> animalsOfSelectedCategory = animals.where((a) => a.category.name == categories[1].name.toLowerCase()).toList();
        emit(CategoriesLoaded(categories: categories, index: 1, animals: animalsOfSelectedCategory));
      } on Exception{
        emit(const CategoriesError(message: 'Error getting data.'));
      }
    });

    on<OnCategorySelected>((event, emit) async{
      try{
        
        final List<AnimalModel> animalsOfSelectedCategory = animals.where((a) => a.category.name == event.category.name.toLowerCase()).toList();
        emit(
          CategoriesLoaded(
            categories: categories, 
            index: event.index, 
            animals: animalsOfSelectedCategory
          )
        );
      } on Exception{
        emit(const CategoriesError(message: 'Error getting data.'));
      }
    });
  }
}

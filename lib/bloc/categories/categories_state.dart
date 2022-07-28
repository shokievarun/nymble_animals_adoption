part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState extends Equatable{
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {

  const CategoriesInitial();

  @override
  List<Object?> get props => [];
}

class CategoriesLoading extends CategoriesState{

  const CategoriesLoading();
  
  @override
  List<Object?> get props => [];
}

class CategoriesLoaded extends CategoriesState{
  
  final List<CategoryModel> categories;
  final int index;
  final List<AnimalModel> animals;

  const CategoriesLoaded({
    required this.categories,
    required this.index,
    required this.animals
  });

  @override
  List<Object?> get props => [categories, index, animals];
}

class CategoriesError extends CategoriesState{

  final String message;

  const CategoriesError({
    required this.message
  });

  @override
  List<Object?> get props => [message];
}


part of 'categories_bloc.dart';


// ! ALL EVENTS OF CATEGORIES BLOC


@immutable
abstract class CategoriesEvent extends Equatable{
  const CategoriesEvent();
}

class GetCategories extends CategoriesEvent{

  @override
  List<Object?> get props => [];
}

class OnCategorySelected extends CategoriesEvent{

  final CategoryModel category;
  final int index;

  const OnCategorySelected({
    required this.category,
    required this.index
  });

  @override
  List<Object?> get props => [category, index];
}

import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/models/category_model.dart';

import 'assets_paths.dart';


const double topPaddingPercent = 0.075;
const double bottomPaddingPercent = 0.015;
const double sidesPaddingPercent = 0.05;

List<CategoryModel> categories = [
  CategoryModel(
    name: 'Dogs', 
    description: 'There are 5 dogs near you!', 
    imagePath: '$animalCategoriesPath/dog.png'
  ),
  CategoryModel(
    name: 'Cats', 
    description: 'There are 10 cats near you!', 
    imagePath: '$animalCategoriesPath/cat.png'
  ),
  CategoryModel(
    name: 'Fishes', 
    description: 'There are 100 fishes near you!', 
    imagePath: '$animalCategoriesPath/fish.png'
  ),
  CategoryModel(
    name: 'Birds', 
    description: 'There are 1 bird near you!', 
    imagePath: '$animalCategoriesPath/bird.png'
  ),
  CategoryModel(
    name: 'Rabbits', 
    description: 'There are 25 rabbits near you!', 
    imagePath: '$animalCategoriesPath/rabbit.png'
  ),
];

List<AnimalModel> animals = [
  AnimalModel(
    name: 'Kenya', 
    description: '', 
    imagePath: 'https://www.collinsdictionary.com/images/thumb/cat_156310937_250.jpg?version=4.0.267', 
    location: 'Tijuana, BC',
    distanceInKm: 15
  ),
  AnimalModel(
    name: 'Jasper', 
    description: '', 
    imagePath: 'https://images-na.ssl-images-amazon.com/images/I/71+mDoHG4mL.png', 
    location: 'Tijuana, BC',
    distanceInKm: 1
  ),
  AnimalModel(
    name: 'Candy', 
    description: '', 
    imagePath: 'https://www.cdc.gov/healthypets/images/kitten-allert.jpg?_=67669', 
    location: 'Tijuana, BC',
    distanceInKm: 12.5
  ),
  AnimalModel(
    name: 'Kimbo', 
    description: '', 
    imagePath: 'https://4fi8v2446i0sw2rpq2a3fg51-wpengine.netdna-ssl.com/wp-content/uploads/2016/06/9-weeks-Tweed.jpg', 
    location: 'Tijuana, BC',
    distanceInKm: 1.12
  ),
  AnimalModel(
    name: 'Camila', 
    description: '', 
    imagePath: 'https://media.baamboozle.com/uploads/images/235599/1621054151_115168_url.jpeg', 
    location: 'Tijuana, BC',
    distanceInKm: 1
  ),
  AnimalModel(
    name: 'Moose', 
    description: '', 
    imagePath: 'https://d17fnq9dkz9hgj.cloudfront.net/uploads/2012/11/95142833-crate-training-cat-632x475.jpg', 
    location: 'Tijuana, BC',
    distanceInKm: 5.25
  ),
];

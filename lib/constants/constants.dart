import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/models/announcement_model.dart';
import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'assets_paths.dart';


const double topPaddingPercent = 0.025;
const double bottomPaddingPercent = 0.025;
const double sidesPaddingPercent = 0.075;

const int maxAnimalsToShowInVertialList = 5;


List<BoxShadow> containerShadows = [
  BoxShadow(
    blurRadius: 50,
    color: Colors.grey[200]!,
    offset: const Offset(0, 5),
  )
];

List<CategoryModel> categories = [
  CategoryModel(
    category: Category.dogs, 
    description: 'There are 5 dogs near you!', 
    imagePath: '$animalCategoriesPath/dog_category.jpg'
  ),
  CategoryModel(
    category: Category.cats,
    description: 'There are 10 cats near you!', 
    imagePath: '$animalCategoriesPath/cat_category.jpg'
  ),
  CategoryModel(
    category: Category.fishes,
    description: 'There are 100 fishes near you!', 
    imagePath: '$animalCategoriesPath/fish_category.jpg'
  ),
  CategoryModel(
    category: Category.birds,
    description: 'There are 1 bird near you!', 
    imagePath: '$animalCategoriesPath/bird_category.jpg'
  ),
  CategoryModel(
    category: Category.rabbits,
    description: 'There are 25 rabbits near you!', 
    imagePath: '$animalCategoriesPath/rabbit_category.jpg'
  ),
];

List<AnimalModel> animals = [
  AnimalModel(
    name: 'Kenya', 
    description: 'No description.', 
    imagePath: 'https://www.collinsdictionary.com/images/thumb/cat_156310937_250.jpg?version=4.0.267', 
    location: 'Tijuana, BC',
    distanceInKm: 15,
    category: Category.cats,
    age: 1,
    sex: 'Female',
    weight: 15
  ),
  AnimalModel(
    name: 'Jasper', 
    description: 'No description.', 
    imagePath: 'https://images-na.ssl-images-amazon.com/images/I/71+mDoHG4mL.png', 
    location: 'Tijuana, BC',
    distanceInKm: 1,
    category: Category.cats,
    age: 1,
    sex: 'Female',
    weight: 15
  ),
  AnimalModel(
    name: 'Candy', 
    description: 'No description.', 
    imagePath: 'https://www.cdc.gov/healthypets/images/kitten-allert.jpg?_=67669', 
    location: 'Tijuana, BC',
    distanceInKm: 12.5,
    category: Category.cats,
    age: 1,
    sex: 'Female',
    weight: 15
  ),
  AnimalModel(
    name: 'Kimbo', 
    description: 'No description.', 
    imagePath: 'https://4fi8v2446i0sw2rpq2a3fg51-wpengine.netdna-ssl.com/wp-content/uploads/2016/06/9-weeks-Tweed.jpg', 
    location: 'Tijuana, BC',
    distanceInKm: 1.12,
    category: Category.cats,
    age: 1,
    sex: 'Female',
    weight: 15
  ),
  AnimalModel(
    name: 'Camila', 
    description: 'No description.', 
    imagePath: 'https://st2.depositphotos.com/2222024/5819/i/450/depositphotos_58199799-stock-photo-beautiful-happy-reddish-havanese-puppy.jpg', 
    location: 'Tijuana, BC',
    distanceInKm: 1,
    category: Category.cats,
    age: 1,
    sex: 'Female',
    weight: 15
  ),
  AnimalModel(
    name: 'Moose', 
    description: 'No description.', 
    imagePath: 'https://d17fnq9dkz9hgj.cloudfront.net/uploads/2012/11/95142833-crate-training-cat-632x475.jpg', 
    location: 'Tijuana, BC',
    distanceInKm: 5.25,
    category: Category.cats,
    age: 1,
    sex: 'Female',
    weight: 15
  ),
];

List<AnnouncementModel> announcements = const [
  AnnouncementModel(title: 'Announcement 1', description: 'Check all the pets available in our application.', imageURL: '$animalImagesPath/petadoption.png'),
  AnnouncementModel(title: 'Announcement 2', description: 'Check your messages.', imageURL: '$illustrationsPath/no_messages.png'),
  AnnouncementModel(title: 'Announcement 3', description: 'Check your location.', imageURL: '$illustrationsPath/map.png'),
  AnnouncementModel(title: 'Announcement 4', description: 'Check your configuration.', imageURL: '$illustrationsPath/user.png'),

];
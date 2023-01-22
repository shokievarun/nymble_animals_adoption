import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/db/pet.dart';
import 'package:hive/hive.dart';

class HiveDB {
  static var animalModelBox = Hive.box('animalBox');

  static init() async {
    animalModelBox = Hive.box('animalBox');
  }

// Delete AnimalModel from AnimalModel animalModelBox
  static deleteAnimalModel(int index) {
    animalModelBox.deleteAt(index);
  }

  // Update AnimalModel of AnimalModel animalModelBox
  static updateAnimalModel(int index, AnimalModel newAnimalModel) {
    // AnimalModel newAnimalModel = AnimalModel(
    //   name: name,
    //   id: id,
    // );
    animalModelBox.putAt(index, newAnimalModel);
  }

  // Add from animalModelBox
  static addAnimalModel(AnimalModel newAnimalModel) async {
    animalModelBox.add(newAnimalModel);
  }

// // get from animalModelBox
//   static AnimalModel getAnimalModelWithIndex(int index) {
//     var AnimalModelData = animalModelBox.getAt(index)!;
//     AppLogger.log('AnimalModel updated in animalModelBox!');
//     return AnimalModelData;
//   }

  // static getAnimalModelsList() {
  //   //get AnimalModels as a List
  //   List<AnimalModel> AnimalModels = Hive.box<AnimalModel>("animalModelBox").values.toList();
  //   AnimalModels = getAnimalModelsSortedByOrder(AnimalModels);
  //   return AnimalModels;
  // }

// get sorted List of AnimalModel from animalModelBox
  static getAnimalModelsSortedByOrder(List<AnimalModel> animalModels) {
    //ordering AnimalModel list by position
    animalModels.sort((a, b) {
      var aID = a.adoptedDate;
      var bID = b.adoptedDate;
      return aID.compareTo(bID);
    });
    return animalModels;
  }

// get List of AnimalModel from animalModelBox
  static List<AnimalModel> getAnimalModelsList() {
    var animalModelJson = animalModelBox.toMap();
    List<AnimalModel> animalModelData = [];

    animalModelData = [
      for (var e in animalModelJson.entries)
        AnimalModel(
            name: e.value.name,
            id: e.value.id,
            adoptedDate: e.value.adoptedDate,
            age: e.value.age,
            category: e.value.category,
            description: e.value.description,
            imagePath: e.value.imagePath,
            isAdopted: e.value.isAdopted,
            price: e.value.price,
            sex: e.value.sex,
            weight: e.value.weight)
    ];

    return animalModelData;
  }

  static List<AnimalModel> getData(bool isFomHistory) {
    List<AnimalModel> animalsOfSelectedCategory = [];

    try {
      animalsOfSelectedCategory = HiveDB.getAnimalModelsList();
    } catch (err) {
      print(err);
    }

    if (animalsOfSelectedCategory != null &&
        animalsOfSelectedCategory.isNotEmpty) {
      if (isFomHistory) {
        animalsOfSelectedCategory
            .sort((b, a) => a.adoptedDate.compareTo(b.adoptedDate));
      }

      return animalsOfSelectedCategory;
    } else {
      animalsOfSelectedCategory = animals;
      for (var e in animals) {
        HiveDB.addAnimalModel(e);
      }
      if (isFomHistory) {
        animalsOfSelectedCategory
            .sort((b, a) => a.adoptedDate.compareTo(b.adoptedDate));
      }
      return animalsOfSelectedCategory;
    }
  }
//     if (AnimalModelList == e.value) {
//      /* moneyLottoBox.put('AnimalModelList', <int>[7]); this statement is the
// reason for your error because your are storing a growable list instead of fixed list in the hive */

// animalModelBox.put('AnimalModelList', [1,2,3,4,5,6,7]);// try this instead
// // or u can use this moneyLottoBox.put('AnimalModelList', AnimalModelList);
//       AnimalModelList = moneyLottoBox.get('AnimalModelList');
//     }

  // List<AnimalModel> AnimalModelList = AnimalModelJson
  //     .map((entry) => AnimalModel(name: entry.value.name, id: entry.value.id))
  //     .toList();

  //AnimalModelData.forEach((name,id) => AnimalModelData.add(AnimalModel(name:name,id:id)));

}

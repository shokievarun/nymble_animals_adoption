import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:animals_adoption_flutter/db/pet.dart';
import 'package:animals_adoption_flutter/screens/animal_details/animal_details_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Adoption', () {
    test('value should be incremented', () {
      final adoption = AnimalDetailsPage(
          animal: AnimalModel(
              id: 41,
              adoptedDate:
                  DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
              name: 'Buttu',
              description: 'Cats 41 description.',
              imagePath:
                  'https://www.alleycat.org/wp-content/uploads/2019/03/FELV-cat.jpg',
              category: 'cats',
              age: 2,
              sex: 'Male',
              weight: 1,
              isAdopted: false,
              price: 2000),
          index: 0);

      expect(adoption.animal.isAdopted, false);
    });
  });
}

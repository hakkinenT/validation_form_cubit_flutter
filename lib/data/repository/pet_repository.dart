import '../model/pet.dart';

class PetRepository {
  final _pets = <Pet>[];

  List<Pet> get pets => _pets;

  bool get isEmpty => _pets.isEmpty;

  void addPet(Pet pet) {
    _pets.add(pet);
  }

  void updatePet(Pet pet) {
    int petIndex = _pets.indexWhere((p) => p.id == pet.id);

    _pets[petIndex] = pet;
  }

  void removePet(String petId) {
    _pets.removeWhere((pet) => pet.id == petId);
  }

  void removeAll() {
    _pets.clear();
  }
}

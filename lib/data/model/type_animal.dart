enum TypeAnimal { cat, dog }

extension TypeAnimalExt on TypeAnimal {
  String? get name {
    switch (this) {
      case TypeAnimal.cat:
        return 'Gato';
      case TypeAnimal.dog:
        return 'Cachorro';
      default:
        return null;
    }
  }
}

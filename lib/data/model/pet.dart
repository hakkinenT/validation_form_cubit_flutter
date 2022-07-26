import 'package:bloc_textfield/data/model/type_animal.dart';

class Pet {
  final String? id;
  final String name;
  final int age;
  final TypeAnimal typeAnimal;
  final DateTime? birthday;

  Pet(
      {this.id,
      required this.name,
      required this.age,
      required this.typeAnimal,
      this.birthday});

  Pet copyWith(
      {String? id,
      String? name,
      int? age,
      TypeAnimal? typeAnimal,
      DateTime? birthday}) {
    return Pet(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        typeAnimal: typeAnimal ?? this.typeAnimal,
        birthday: birthday ?? this.birthday);
  }
}

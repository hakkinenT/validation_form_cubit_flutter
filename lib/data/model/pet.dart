class Pet {
  final String? id;
  final String name;
  final int age;

  Pet({this.id, required this.name, required this.age});

  Pet copyWith({String? id, String? name, int? age}) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}

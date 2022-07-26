import 'package:bloc_textfield/form_validator/form_input_validator.dart';

class TypeAnimalInput extends FormInput {
  final String? value;
  TypeAnimalInput({required this.value});

  @override
  bool get invalid => value == null;

  @override
  String? get onError {
    if (invalid) {
      return 'Selecione um tipo';
    } else {
      return null;
    }
  }

  @override
  bool get valid => value != null;
}

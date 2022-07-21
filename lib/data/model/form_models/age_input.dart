import 'package:bloc_textfield/common/regex.dart';
import 'package:bloc_textfield/form_validator/form_input_validator.dart';

class AgeInput extends FormInput {
  final String value;
  AgeInput({required this.value});

  final RegExp _regExp = RegExp(regexNumberInput);

  @override
  bool get invalid => _regExp.hasMatch(value) == false;

  @override
  String? get onError {
    if (invalid) {
      return 'Informe a idade';
    } else {
      return null;
    }
  }

  @override
  bool get valid => _regExp.hasMatch(value) == true;
}

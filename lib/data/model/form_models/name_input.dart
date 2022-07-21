import 'package:bloc_textfield/form_validator/form_input_validator.dart';

import '../../../common/regex.dart';

class NameInput extends FormInput {
  final String value;

  NameInput({required this.value});

  final RegExp _regExp = RegExp(regexInputText);

  @override
  bool get invalid => _regExp.hasMatch(value) == false;

  @override
  String? get onError {
    if (invalid) {
      return 'Informe o nome';
    } else {
      return null;
    }
  }

  @override
  bool get valid => _regExp.hasMatch(value) == true;
}

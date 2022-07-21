import 'package:bloc_textfield/form_validator/form_input_validator.dart';

enum FormStatus { validated, invalid }

class FormValidator {
  //late final List<FormInput?> _formInputs;

  FormValidator();

  static FormStatus validate({required List<FormInput?> inputs}) {
    //_formInputs = inputs;
    final isValidate = inputs.every((input) => input?.invalid == false);
    if (isValidate) {
      return FormStatus.validated;
    } else {
      return FormStatus.invalid;
    }
  }

  //bool get isValidate => validate(inputs: _formInputs) == FormStatus.validated;
}

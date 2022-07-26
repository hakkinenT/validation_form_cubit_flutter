import 'package:bloc_textfield/form_validator/form_input_validator.dart';

enum FormStatus { validated, invalid }

class FormValidator {
  FormValidator();

  static FormStatus validate({required List<FormInput?> inputs}) {
    final isValidate = inputs.every((input) => input?.invalid == false);
    if (isValidate) {
      return FormStatus.validated;
    } else {
      return FormStatus.invalid;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:bloc_textfield/data/model/form_models/age_input.dart';
import 'package:bloc_textfield/data/model/form_models/name_input.dart';
import 'package:bloc_textfield/form_validator/form_validator.dart';
import 'package:equatable/equatable.dart';

import '../data/model/pet.dart';

part 'pet_validation_state.dart';

class PetValidationCubit extends Cubit<PetValidationState> {
  PetValidationCubit() : super(const PetValidationState());

  void nameChanged(String name) {
    final nameInput = NameInput(value: name);
    emit(state.copyWith(
        nameInput: nameInput,
        status: FormValidator.validate(inputs: [nameInput, state.ageInput])));
  }

  void ageChanged(String age) {
    final ageInput = AgeInput(value: age);
    emit(state.copyWith(
        ageInput: ageInput,
        status: FormValidator.validate(inputs: [state.nameInput, ageInput])));
  }

  void updateInputs(Pet pet) {
    final nameInput = NameInput(value: pet.name);
    final ageInput = AgeInput(value: pet.age.toString());
    emit(state.copyWith(
        nameInput: nameInput,
        ageInput: ageInput,
        status: FormValidator.validate(inputs: [nameInput, ageInput])));
  }
}

import 'package:bloc/bloc.dart';
import 'package:bloc_textfield/common/enum_map.dart';
import 'package:bloc_textfield/data/model/form_models/age_input.dart';
import 'package:bloc_textfield/data/model/form_models/name_input.dart';
import 'package:bloc_textfield/data/model/form_models/type_input.dart';
import 'package:bloc_textfield/form_validator/form_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/model/pet.dart';

part 'pet_validation_state.dart';

class PetValidationCubit extends Cubit<PetValidationState> {
  PetValidationCubit()
      : super(PetValidationState(
          nameInput: NameInput(value: ''),
          ageInput: AgeInput(value: ''),
          typeAnimalInput: TypeAnimalInput(value: null),
          birthday: null,
          nameFocusNode: FocusNode(),
          ageFocusNode: FocusNode(),
          typeAnimalFocusNode: FocusNode(),
        ));

  void nameChanged(String name) {
    final nameInput = NameInput(value: name);
    emit(state.copyWith(
        nameInput: nameInput,
        status: FormValidator.validate(
            inputs: [nameInput, state.ageInput, state.typeAnimalInput])));
  }

  void ageChanged(String age) {
    final ageInput = AgeInput(value: age);
    emit(state.copyWith(
        ageInput: ageInput,
        status: FormValidator.validate(
            inputs: [state.nameInput, ageInput, state.typeAnimalInput])));
  }

  void typeAnimalChanged(String? typeAnimal) {
    final typeAnimalInput = TypeAnimalInput(value: typeAnimal);

    emit(state.copyWith(
        typeAnimalInput: typeAnimalInput,
        status: FormValidator.validate(inputs: [
          state.nameInput,
          state.ageInput,
          typeAnimalInput,
        ])));
  }

  void setBirthday(String birthday) {
    emit(state.copyWith(
      birthday: TextEditingController(text: birthday),
    ));
  }

  void _nameValidated() {
    if (!state.nameFocusNode.hasFocus) {
      if (state.nameInput!.invalid) {
        emit(state.copyWith(nameIsNotValidated: false));
      } else {
        emit(state.copyWith(nameIsNotValidated: true));
      }
    }
  }

  void _ageValidated() {
    if (!state.ageFocusNode.hasFocus) {
      if (state.ageInput!.invalid) {
        emit(state.copyWith(ageIsNotValidated: false));
      } else {
        emit(state.copyWith(ageIsNotValidated: true));
      }
    }
  }

  void _typeAnimalValidated() {
    if (!state.typeAnimalFocusNode.hasFocus) {
      if (state.typeAnimalInput!.invalid) {
        emit(state.copyWith(typeAnimalIsNotValidated: false));
      } else {
        emit(state.copyWith(typeAnimalIsNotValidated: true));
      }
    }
  }

  void nameInputListener() {
    state.nameFocusNode.addListener(() {
      _nameValidated();
    });
  }

  void ageInputListener() {
    state.ageFocusNode.addListener(() {
      _ageValidated();
    });
  }

  void typeAnimalListener() {
    state.typeAnimalFocusNode.addListener(() {
      _typeAnimalValidated();
    });
  }

  void updateInputs(Pet pet) {
    final nameInput = NameInput(value: pet.name);
    final ageInput = AgeInput(value: pet.age.toString());
    final typeAnimalInput =
        TypeAnimalInput(value: typeAnimalToString[pet.typeAnimal]);
    final birthday = pet.birthday == null
        ? TextEditingController(text: '')
        : TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(pet.birthday!));

    emit(state.copyWith(
        nameInput: nameInput,
        ageInput: ageInput,
        typeAnimalInput: typeAnimalInput,
        birthday: birthday,
        status: FormValidator.validate(
            inputs: [nameInput, ageInput, typeAnimalInput])));
  }

  _removeListeners() {
    state.nameFocusNode.removeListener(() {});
    state.ageFocusNode.removeListener(() {});
    state.typeAnimalFocusNode.removeListener(() {});
  }

  _disposeNodes() {
    state.nameFocusNode.dispose();
    state.ageFocusNode.dispose();
    state.typeAnimalFocusNode.dispose();
  }

  @override
  Future<void> close() {
    _removeListeners();
    _disposeNodes();
    state.birthday?.dispose();
    return super.close();
  }
}

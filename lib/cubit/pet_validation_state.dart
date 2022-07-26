part of 'pet_validation_cubit.dart';

class PetValidationState extends Equatable {
  const PetValidationState(
      {this.nameInput,
      this.ageInput,
      this.typeAnimalInput,
      this.birthday,
      this.status,
      required this.nameFocusNode,
      required this.ageFocusNode,
      required this.typeAnimalFocusNode,
      this.nameIsNotValidated = true,
      this.ageIsNotValidated = true,
      this.typeAnimalIsNotValidated = true});

  final NameInput? nameInput;
  final AgeInput? ageInput;
  final TypeAnimalInput? typeAnimalInput;
  final TextEditingController? birthday;
  final FormStatus? status;
  final bool? nameIsNotValidated;
  final bool? ageIsNotValidated;
  final bool? typeAnimalIsNotValidated;
  final FocusNode nameFocusNode;
  final FocusNode ageFocusNode;
  final FocusNode typeAnimalFocusNode;

  @override
  List<Object?> get props => [
        nameInput,
        ageInput,
        typeAnimalInput,
        birthday,
        status,
        nameIsNotValidated,
        ageIsNotValidated,
        typeAnimalIsNotValidated,
        nameFocusNode,
        ageFocusNode,
        typeAnimalFocusNode,
      ];

  PetValidationState copyWith(
      {NameInput? nameInput,
      AgeInput? ageInput,
      TypeAnimalInput? typeAnimalInput,
      TextEditingController? birthday,
      FormStatus? status,
      bool? nameIsNotValidated,
      bool? ageIsNotValidated,
      bool? typeAnimalIsNotValidated,
      FocusNode? nameFocusNode,
      FocusNode? ageFocusNode,
      FocusNode? typeAnimalFocusNode}) {
    return PetValidationState(
        nameInput: nameInput ?? this.nameInput,
        ageInput: ageInput ?? this.ageInput,
        typeAnimalInput: typeAnimalInput ?? this.typeAnimalInput,
        birthday: birthday ?? this.birthday,
        status: status ?? this.status,
        ageIsNotValidated: ageIsNotValidated ?? this.ageIsNotValidated,
        nameIsNotValidated: nameIsNotValidated ?? this.nameIsNotValidated,
        typeAnimalIsNotValidated:
            typeAnimalIsNotValidated ?? this.typeAnimalIsNotValidated,
        nameFocusNode: nameFocusNode ?? this.nameFocusNode,
        ageFocusNode: ageFocusNode ?? this.ageFocusNode,
        typeAnimalFocusNode: typeAnimalFocusNode ?? this.typeAnimalFocusNode);
  }
}

part of 'pet_validation_cubit.dart';

class PetValidationState extends Equatable {
  const PetValidationState({this.nameInput, this.ageInput, this.status});

  final NameInput? nameInput;
  final AgeInput? ageInput;
  final FormStatus? status;

  @override
  List<Object?> get props => [nameInput, ageInput, status];

  PetValidationState copyWith(
      {NameInput? nameInput, AgeInput? ageInput, FormStatus? status}) {
    return PetValidationState(
        nameInput: nameInput ?? this.nameInput,
        ageInput: ageInput ?? this.ageInput,
        status: status ?? this.status);
  }
}

/*class PetValidating extends PetValidationState {
  const PetValidating({NameInput? nameInput, AgeInput? ageInput})
      : super(nameInput: nameInput, ageInput: ageInput);
}

class PetValidated extends PetValidationState {
  const PetValidated({NameInput? nameInput, AgeInput? ageInput})
      : super(ageInput: ageInput, nameInput: nameInput);
}*/

part of 'pet_cubit.dart';

@immutable
abstract class PetState extends Equatable {
  const PetState();
  @override
  List<Object?> get props => [];
}

class PetInitial extends PetState {
  const PetInitial();
}

class PetLoading extends PetState {
  const PetLoading();
}

class PetLoaded extends PetState {
  final List<Pet> pets;
  const PetLoaded({required this.pets});

  @override
  List<Object?> get props => [pets];

  PetLoaded copyWith({List<Pet>? pets}) {
    return PetLoaded(pets: pets ?? this.pets);
  }
}

class PetSuccess extends PetState {
  const PetSuccess();
}

class PetFailure extends PetState {
  const PetFailure();
}

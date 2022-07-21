import 'package:bloc/bloc.dart';
import 'package:bloc_textfield/data/model/pet.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../data/repository/pet_repository.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final PetRepository _petRepository;
  PetCubit()
      : _petRepository = PetRepository(),
        super(const PetInitial());

  void savePet(Pet pet) async {
    emit(const PetLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (pet.id == null) {
        final newPet = pet.copyWith(id: const Uuid().v4());
        _petRepository.addPet(newPet);
      } else {
        _petRepository.updatePet(pet);
      }
      emit(const PetSuccess());
    } on Exception catch (e) {
      emit(const PetFailure());
    }
  }

  void deletePets() async {
    emit(const PetLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      _petRepository.removeAll();
      emit(const PetLoaded(pets: []));
    } on Exception {
      emit(const PetFailure());
    }
  }

  void deletePet(String petId) async {
    emit(const PetLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      _petRepository.removePet(petId);
      getAllPets();
    } on Exception {
      emit(const PetFailure());
    }
  }

  void getAllPets() async {
    emit(const PetLoading());
    try {
      final pets = _petRepository.pets;
      emit(PetLoaded(pets: pets));
    } on Exception {
      emit(const PetFailure());
    }
  }
}

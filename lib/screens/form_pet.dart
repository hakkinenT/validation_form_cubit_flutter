import 'package:bloc_textfield/common/enum_map.dart';
import 'package:bloc_textfield/cubit/pet_validation_cubit.dart';
import 'package:bloc_textfield/data/model/pet.dart';
import 'package:bloc_textfield/data/model/type_animal.dart';
import 'package:bloc_textfield/form_validator/form_validator.dart';
import 'package:bloc_textfield/screens/widgets/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/pet_cubit.dart';

class FormPetScreen extends StatelessWidget {
  final Pet? pet;
  const FormPetScreen({Key? key, this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: BlocProvider.of<PetCubit>(context)),
      BlocProvider(create: (context) => PetValidationCubit()),
    ], child: PetFormView(pet: pet));
  }
}

class PetFormView extends StatefulWidget {
  final Pet? pet;
  const PetFormView({Key? key, this.pet}) : super(key: key);

  @override
  State<PetFormView> createState() => _PetFormViewState();
}

class _PetFormViewState extends State<PetFormView> {
  final FocusNode _birthdayFocusNode = FocusNode();

  String _textScreen = 'Cadastrar Pet';

  @override
  void initState() {
    if (widget.pet != null) {
      _textScreen = 'Editar Pet';
      context.read<PetValidationCubit>().updateInputs(widget.pet!);
    }

    ///Valida os campos quando há uma mudança de foco entre eles
    context.read<PetValidationCubit>().nameInputListener();
    context.read<PetValidationCubit>().ageInputListener();
    context.read<PetValidationCubit>().typeAnimalListener();

    super.initState();
  }

  @override
  void dispose() {
    _birthdayFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_textScreen),
      ),
      body: BlocListener<PetCubit, PetState>(
        listener: (context, state) {
          if (state is PetInitial) {
            const SizedBox();
          } else if (state is PetLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                });
          } else if (state is PetSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                  content: Text('Operação realizada com sucesso!')));
            Navigator.pop(context);
            context.read<PetCubit>().getAllPets();
          } else if (state is PetLoaded) {
            Navigator.pop(context);
          } else if (state is PetFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  const SnackBar(content: Text('Erro ao atualizar pet')));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const _NameInput(),
              const SizedBox(
                height: 16,
              ),
              const _AgeInput(),
              const SizedBox(
                height: 16,
              ),
              _TypeAnimalInput(birthdayFocusNode: _birthdayFocusNode),
              const SizedBox(
                height: 16,
              ),
              _BirthdayInput(birthdayFocusNode: _birthdayFocusNode),
              const SizedBox(
                height: 16,
              ),
              _PetFormButton(
                petId: widget.pet?.id,
                textScreen: _textScreen,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetValidationCubit, PetValidationState>(
      builder: (context, state) {
        return TextFormField(
          key: const ValueKey('textField_namePet'),
          autofocus: true,
          initialValue: state.nameInput?.value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: state.nameFocusNode,
          textInputAction: TextInputAction.next,
          onEditingComplete: state.ageFocusNode.requestFocus,
          onChanged: (name) {
            context.read<PetValidationCubit>().nameChanged(name);
          },
          decoration: InputDecoration(
              hintText: 'Nome',
              border: const OutlineInputBorder(),
              errorText:
                  state.nameIsNotValidated! ? null : state.nameInput?.onError),
        );
      },
    );
  }
}

class _AgeInput extends StatelessWidget {
  const _AgeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetValidationCubit, PetValidationState>(
      builder: (context, state) {
        return TextFormField(
          key: const ValueKey('textField_idadePet'),
          initialValue: state.ageInput?.value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: state.ageFocusNode,
          onEditingComplete: state.typeAnimalFocusNode.requestFocus,
          textInputAction: TextInputAction.next,
          onChanged: (age) {
            context.read<PetValidationCubit>().ageChanged(age);
          },
          decoration: InputDecoration(
              hintText: 'Idade',
              border: const OutlineInputBorder(),
              errorText:
                  state.ageIsNotValidated! ? null : state.ageInput?.onError),
        );
      },
    );
  }
}

class _TypeAnimalInput extends StatelessWidget {
  final FocusNode birthdayFocusNode;
  const _TypeAnimalInput({Key? key, required this.birthdayFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetValidationCubit, PetValidationState>(
        builder: (context, state) {
      return CustomDropDownButton(
        key: const ValueKey('dropMenu_type'),
        hintText: 'Tipo',
        initialValue: state.typeAnimalInput?.value,
        focusNode: state.typeAnimalFocusNode,
        onChanged: (type) {
          FocusScope.of(context).requestFocus(FocusNode());
          context.read<PetValidationCubit>().typeAnimalChanged(type);
          birthdayFocusNode.requestFocus();
        },
        errorText: state.typeAnimalIsNotValidated!
            ? null
            : state.typeAnimalInput?.onError,
        width: double.maxFinite,
      );
    });
  }
}

class _BirthdayInput extends StatelessWidget {
  final FocusNode birthdayFocusNode;
  const _BirthdayInput({Key? key, required this.birthdayFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetValidationCubit, PetValidationState>(
      builder: (context, state) {
        return TextFormField(
          key: const ValueKey('textField_birthdayPet'),
          controller: state.birthday,
          focusNode: birthdayFocusNode,
          textInputAction: TextInputAction.done,
          readOnly: true,
          decoration: InputDecoration(
              hintText: 'Data de Nascimento',
              label: const Text('Data de Nascimento 1 (Opcional)'),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2030),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);

                      context
                          .read<PetValidationCubit>()
                          .setBirthday(formattedDate);
                    }
                  },
                  icon: const Icon(Icons.calendar_today))),
        );
      },
    );
  }
}

class _PetFormButton extends StatelessWidget {
  final String? petId;
  final String textScreen;
  const _PetFormButton(
      {Key? key, required this.petId, required this.textScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetValidationCubit, PetValidationState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 52,
          child: ElevatedButton(
            child: Text(textScreen),
            onPressed: state.status == FormStatus.validated
                ? () {
                    final pet = Pet(
                        id: petId,
                        name: state.nameInput!.value,
                        age: int.parse(state.ageInput!.value),
                        birthday: state.birthday?.text == null
                            ? null
                            : DateFormat('dd/MM/yyyy')
                                .parse(state.birthday!.text),
                        typeAnimal:
                            stringToTypeAnimal[state.typeAnimalInput!.value]!);
                    context.read<PetCubit>().savePet(pet);
                  }
                : null,
          ),
        );
      },
    );
  }
}

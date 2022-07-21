import 'package:bloc_textfield/cubit/pet_validation_cubit.dart';
import 'package:bloc_textfield/data/model/pet.dart';
import 'package:bloc_textfield/form_validator/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();

  String _appBarTitle = 'Cadastrar Pet';
  String _textButton = 'Cadastrar Pet';

  @override
  void initState() {
    if (widget.pet != null) {
      _appBarTitle = 'Editar Pet';
      _textButton = 'Editar Pet';
      context.read<PetValidationCubit>().updateInputs(widget.pet!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
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
              BlocBuilder<PetValidationCubit, PetValidationState>(
                builder: (context, state) {
                  return TextFormField(
                    key: const ValueKey('textField_namePet'),
                    initialValue: state.nameInput?.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _nameFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: _ageFocusNode.requestFocus,
                    onChanged: (name) {
                      context.read<PetValidationCubit>().nameChanged(name);
                    },
                    validator: (value) {
                      if (state.status == FormStatus.invalid) {
                        return state.nameInput?.onError;
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Nome', border: OutlineInputBorder()),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<PetValidationCubit, PetValidationState>(
                builder: (context, state) {
                  return TextFormField(
                    key: const ValueKey('textField_idadePet'),
                    initialValue: state.ageInput?.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _ageFocusNode,
                    textInputAction: TextInputAction.done,
                    onChanged: (age) {
                      context.read<PetValidationCubit>().ageChanged(age);
                    },
                    validator: (value) {
                      if (state.status == FormStatus.invalid) {
                        return state.ageInput?.onError;
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Idade', border: OutlineInputBorder()),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<PetValidationCubit, PetValidationState>(
                builder: (context, state) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 52,
                    child: ElevatedButton(
                      child: Text(_textButton),
                      onPressed: state.status == FormStatus.validated
                          ? () {
                              final pet = Pet(
                                  id: widget.pet?.id,
                                  name: state.nameInput!.value,
                                  age: int.parse(state.ageInput!.value));
                              context.read<PetCubit>().savePet(pet);
                            }
                          : null,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

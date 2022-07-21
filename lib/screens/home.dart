import 'package:bloc_textfield/cubit/pet_cubit.dart';
import 'package:bloc_textfield/screens/form_pet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/pet.dart';

class PetHomePage extends StatelessWidget {
  const PetHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PetCubit>(context)..getAllPets(),
      child: const PetsView(),
    );
  }
}

class PetsView extends StatelessWidget {
  const PetsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de pets'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Excuir todos os pets'),
                          content: const Text('Confirmar operação?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar')),
                            TextButton(
                                onPressed: () {
                                  context.read<PetCubit>().deletePets();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(const SnackBar(
                                        content: Text(
                                            'Notas excluidas com sucesso')));
                                },
                                child: const Text('OK'))
                          ],
                        ));
              },
              icon: const Icon(Icons.clear_all))
        ],
      ),
      body: const _Content(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormPetScreen(pet: null)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PetCubit>().state;

    if (state is PetInitial) {
      return const SizedBox();
    } else if (state is PetLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (state is PetLoaded) {
      if (state.pets.isEmpty) {
        return const Center(
          child: Text(
              'Não há pets cadastrados. Clique no botão abaixo para cadastrar um pet.'),
        );
      } else {
        return _PetList(pets: state.pets);
      }
    } else {
      return const Center(
        child: Text('Erro ao recuperar pets'),
      );
    }
  }
}

class _PetList extends StatelessWidget {
  final List<Pet> pets;
  const _PetList({Key? key, required this.pets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final pet in pets) ...[
          Padding(
            padding: const EdgeInsets.all(2.5),
            child: ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Text(pet.name),
              subtitle: Text(pet.age.toString()),
              trailing: Wrap(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormPetScreen(pet: pet)));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Excluir Pet'),
                                  content: const Text('Confirmar operação?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar')),
                                    TextButton(
                                        onPressed: () {
                                          context
                                              .read<PetCubit>()
                                              .deletePet(pet.id!);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Pet excluida com sucesso')));
                                        },
                                        child: const Text('OK'))
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
          )
        ]
      ],
    );
  }
}

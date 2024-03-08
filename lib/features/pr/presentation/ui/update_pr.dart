import 'package:flutter/material.dart';
import 'package:fpr8/features/pr/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePr extends StatelessWidget {
  UpdatePr({super.key, required this.index});

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _full_description = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Изменение заметки ${index}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_keyForm.currentState!.validate()) return;
          context.read<CounterCubit>().updatePr(
              index, _title.text, _description.text, _full_description.text);
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          return switch (state) {
            CounterInitial() || CounterLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            CounterException() => const Center(
                child: Text('Ошибка'),
              ),
            CounterSuccess() => Builder(
                builder: (context) {
                  _title.text =
                      context.read<CounterCubit>().getPrList[index].title;
                  _description.text =
                      context.read<CounterCubit>().getPrList[index].description;
                  _full_description.text = context
                      .read<CounterCubit>()
                      .getPrList[index]
                      .full_description;
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _keyForm,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Поле пустое';
                              }
                              return null;
                            },
                            controller: _title,
                            decoration: const InputDecoration(
                              label: Text('Название'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Поле пустое';
                              }
                              return null;
                            },
                            controller: _description,
                            minLines: 1,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              label: Text('Краткое описание'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _full_description,
                            minLines: 1,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              label: Text('Описание'),
                              border: OutlineInputBorder(),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
          };
        },
      ),
    );
  }
}

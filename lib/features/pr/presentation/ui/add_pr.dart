import 'package:flutter/material.dart';
import 'package:fpr8/features/pr/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPr extends StatelessWidget {
  AddPr({super.key});

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _fullDesc = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавление заметки"),
      ),
      floatingActionButton:
          BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            if (!_keyForm.currentState!.validate()) return;
            context.read<CounterBloc>().add(OnClickEvent());
            Future.delayed(const Duration(seconds: 5), () {
              context.read<CounterBloc>().add(OnComplite());
              Future.delayed(const Duration(seconds: 5), () {
                context.read<CounterBloc>().add(OnReload());
              });
            });
            context
                .read<CounterBloc>()
                .cubit
                .addPr(_title.text, _description.text, _fullDesc.text);
            //Navigator.pop(context);
          },
          child: switch (state) {
            CounterInitial() => const Icon(
                Icons.save,
                color: Colors.white,
              ),
            CounterLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            _ => const Text("?"),
          },
        );
      }),
      body: Padding(
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
                    //return 'Поле пустое';
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
                controller: _fullDesc,
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
      ),
    );
  }
}

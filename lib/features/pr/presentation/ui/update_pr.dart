import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';

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
          context.read<PrController>().updatePr(
              index, _title.text, _description.text, _full_description.text);
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: switch (
          context.select<PrController, PrState>((value) => value.state)) {
        PrState.initial || PrState.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        PrState.success => Builder(builder: (context) {
            _title.text = context.read<PrController>().getPrList[index].title;
            _description.text =
                context.read<PrController>().getPrList[index].description;
            _full_description.text =
                context.read<PrController>().getPrList[index].full_description;
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
          }),
        PrState.error => const Center(
            child: Text('Ошибка'),
          ),
      },
    );
  }
}

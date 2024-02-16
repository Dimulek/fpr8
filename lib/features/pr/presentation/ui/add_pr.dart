import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';

class AddPr extends StatelessWidget {
  AddPr({super.key});

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _full_description = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавление заметки"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(!_keyForm.currentState!.validate()) return;
          context
              .read<PrController>()
              .addPr(_title.text, _description.text, _full_description.text);
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
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
                    return 'Поле пустое';
                  }
                  return null;
                },
                controller: _description,
                minLines: 3,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле пустое';
                  }
                  return null;
                },
                controller: _full_description,
                minLines: 3,
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

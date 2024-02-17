import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';
import 'package:fpr8/routes/app_router.dart';
import 'package:fpr8/routes/router_utils.dart';

class InfoPr extends StatelessWidget {
  InfoPr({super.key, required this.index});

  // final TextEditingController _title = TextEditingController();
  // final TextEditingController _description = TextEditingController();
  // final TextEditingController _full_description = TextEditingController();
  // final _keyForm = GlobalKey<FormState>();
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PrController>().deletePr(index);
          Navigator.pop(context);
        },
        child: const Icon(Icons.delete_forever),
      ),
      appBar: AppBar(
        title: Text("Заметка ${index}"),
      ),
      body: switch (
          context.select<PrController, PrState>((value) => value.state)) {
        PrState.initial || PrState.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        PrState.success => Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              child: Column(
                children: [
                  const Text("Название: "),
                  Text(context.read<PrController>().getPrList[index].title),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Краткое описание: "),
                  Text(context
                      .read<PrController>()
                      .getPrList[index]
                      .description),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Описание: "),
                  Text(context
                      .read<PrController>()
                      .getPrList[index]
                      .full_description),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppRouter.router.goNamed(Pages.updatePr.screenName,
                          pathParameters: {'id': index.toString()});
                    },
                    child: const Icon(Icons.update),
                  )
                ],
              ),
            ),
          ),
        PrState.error => const Center(
            child: Text('Ошибка'),
          ),
      },
    );
  }
}

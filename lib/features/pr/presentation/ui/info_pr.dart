import 'package:flutter/material.dart';
import 'package:fpr8/features/pr/cubit/counter_cubit.dart';
import 'package:fpr8/routes/app_router.dart';
import 'package:fpr8/routes/router_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoPr extends StatelessWidget {
  InfoPr({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterCubit>().deletePr(index);
          Navigator.pop(context);
        },
        child: const Icon(Icons.delete_forever),
      ),
      appBar: AppBar(
        title: Text("Заметка ${index}"),
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
            CounterSuccess() => Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  child: Column(
                    children: [
                      const Text("Название: "),
                      Text(context.read<CounterCubit>().getPrList[index].title),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Краткое описание: "),
                      Text(context
                          .read<CounterCubit>()
                          .getPrList[index]
                          .description),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Описание: "),
                      Text(context
                          .read<CounterCubit>()
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
          };
        },
      ),
    );
  }
}

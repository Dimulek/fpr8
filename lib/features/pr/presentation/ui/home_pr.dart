import 'package:flutter/material.dart';
import 'package:fpr8/features/pr/cubit/counter_cubit.dart';
import 'package:fpr8/features/pr/presentation/widget/pr_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpr8/routes/app_router.dart';
import 'package:fpr8/routes/router_utils.dart';

import '../widget/custom_app_bar.dart';

class HomePr extends StatelessWidget {
  const HomePr({super.key});
  static Set<int> del_id = new Set<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            heroTag: "MassDeleteButt",
            onPressed: () {
              context.read<CounterCubit>().deleteMassPr(del_id);
              del_id.clear();
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
          FloatingActionButton(
            heroTag: "AddButt",
            onPressed: () {
              AppRouter.router.goNamed(Pages.addPr.screenName);
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          return switch (state) {
            CounterInitial() || CounterLoading() => Builder(
                builder: (context) {
                  context.read<CounterCubit>().init();
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            CounterSuccess() => ListView.builder(
                itemCount: context.select<CounterCubit, int>(
                  (value) => value.getPrList.length,
                ),
                itemBuilder: (context, index) {
                  context.read<CounterCubit>().getPrList[index];
                  return PrCard(
                    index: index,
                  );
                },
              ),
            CounterException() => const Center(
                child: Text('Ошибка'),
              ),
          };
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';
import 'package:fpr8/features/pr/presentation/widget/pr_card.dart';
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
            onPressed: (){
          context.read<PrController>()
              .deleteMassPr(del_id);
              del_id.clear();
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
          FloatingActionButton(
            onPressed: () {
              AppRouter.router.goNamed(Pages.addPr.screenName);
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: switch (
          context.select<PrController, PrState>((value) => value.state)) {
        PrState.initial || PrState.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        PrState.success => ListView.builder(
            itemCount: context.select<PrController, int>(
              (value) => value.getPrList.length,
            ),
            itemBuilder: (context, index) {
              context.read<PrController>().getPrList[index];
              return PrCard(
                index: index,
              );
            }),
        PrState.error => const Center(
            child: Text('Ошибка'),
          ),
      },
    );
  }
}

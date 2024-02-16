import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';
import 'package:fpr8/features/pr/presentation/widget/pr_card.dart';
import 'package:fpr8/routes/app_router.dart';
import 'package:fpr8/routes/router_utils.dart';

import '../widget/custom_app_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.router.goNamed(Pages.addPr.screenName);
        },
        child: const Icon(Icons.add),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';

class PrCard extends StatelessWidget {
  const PrCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(context.read<PrController>().getPrList[index].title),
        leading: ElevatedButton(
          onPressed: () => context.read<PrController>().onTravel(
                index,
              ),
          child: Icon(Icons.mark_as_unread_sharp),
        ),
        children: [
          const Text("Описание"),
          Text(context.read<PrController>().getPrList[index].description),
        ],
      ),
    );
  }
}

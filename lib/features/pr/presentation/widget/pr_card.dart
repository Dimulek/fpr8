import 'package:flutter/material.dart';
import 'package:fpr8/features/pr/cubit/counter_cubit.dart';
import 'package:fpr8/features/pr/presentation/ui/home_pr.dart';
import 'package:fpr8/routes/app_router.dart';
import 'package:fpr8/routes/router_utils.dart';
import 'package:provider/provider.dart';

class PrCard extends StatelessWidget {
  PrCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Row(
          children: <Widget>[
            CheckboxStateful(index: index),
            Text(context.read<CounterCubit>().getPrList[index].title + "  id = ${context.read<CounterCubit>().getPrList[index].id}")
          ],
        ),
        leading: ElevatedButton(
          onPressed: () {
            AppRouter.router.goNamed(Pages.infoPr.screenName,
                pathParameters: {'id': index.toString()});
          },
          child: const Icon(Icons.mark_as_unread_sharp),
        ),
        children: [
          const Text("Краткое описание"),
          Text(context.read<CounterCubit>().getPrList[index].description),
        ],
      ),
    );
  }
}

class CheckboxStateful extends StatefulWidget {
  CheckboxStateful({required this.index, super.key});

  final int index;
  bool is_check = false;

  @override
  State<CheckboxStateful> createState() =>
      _CheckboxStatefulState(index: index, is_check: is_check);
}

class _CheckboxStatefulState extends State<CheckboxStateful> {
  _CheckboxStatefulState({required this.index, required this.is_check});

  final int index;
  bool is_check;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: is_check,
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            is_check = value;
          });
          if (is_check) {
            HomePr.del_id.add(index);
          } else {
            HomePr.del_id.remove(index);
          }
        });
  }
}
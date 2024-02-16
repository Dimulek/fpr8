import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
          'Не выполнено ${context.watch<PrController>().getCount}'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

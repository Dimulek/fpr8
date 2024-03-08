import 'package:fpr8/features/pr/cubit/counter_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:fpr8/di/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpr8/features/pr/presentation/ui/home_pr.dart';
import 'package:fpr8/features/pr/presentation/ui/add_pr.dart';
import 'package:fpr8/features/pr/presentation/ui/update_pr.dart';
import 'package:fpr8/features/pr/presentation/ui/info_pr.dart';
import 'package:fpr8/routes/router_utils.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Pages.home.screenPath,
        name: Pages.home.screenName,
        builder: (context, state) => BlocProvider(
          create: (context) => service<CounterCubit>()..init(),
          child: const HomePr(),
        ),
        routes: [
          GoRoute(
            path: Pages.addPr.screenPath,
            name: Pages.addPr.screenName,
            builder: (context, state) => BlocProvider.value(
              value: service<CounterCubit>(),
              child: AddPr(),
            ),
          ),
          GoRoute(
            path: Pages.infoPr.screenPath,
            name: Pages.infoPr.screenName,
            builder: (context, state) => BlocProvider.value(
              value: service<CounterCubit>(),
              child:
                  InfoPr(index: int.parse(state.pathParameters['id'] ?? "-1")),
            ),
            routes: [
              GoRoute(
                path: Pages.updatePr.screenPath,
                name: Pages.updatePr.screenName,
                builder: (context, state) => BlocProvider.value(
                  value: service<CounterCubit>(),
                  child: UpdatePr(
                      index: int.parse(state.pathParameters['id'] ?? "-1")),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

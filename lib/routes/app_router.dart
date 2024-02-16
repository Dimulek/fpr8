import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fpr8/di/service.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';
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
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => service<PrController>()..init(),
          child: const HomePr(),
        ),
        routes: [
          GoRoute(
            path: Pages.addPr.screenPath,
            name: Pages.addPr.screenName,
            builder: (context, state) => ChangeNotifierProvider.value(
              value: service<PrController>(),
              child: AddPr(),
            ),
          ),
          GoRoute(
            path: Pages.infoPr.screenPath,
            name: Pages.infoPr.screenName,
            builder: (context, state) => ChangeNotifierProvider.value(
              value: service<PrController>(),
              child: InfoPr(),
            ),
            routes: [
              GoRoute(
                path: Pages.updatePr.screenPath,
                name: Pages.updatePr.screenName,
                builder: (context, state) => ChangeNotifierProvider.value(
                  value: service<PrController>(),
                  child: UpdatePr(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

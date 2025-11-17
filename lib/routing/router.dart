import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../ui/Navigation/widget/navigation_screen.dart';
import '../ui/auth/widgets/auth_screen.dart';
import '../ui/register/widgets/register_screen.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.primary,
  routes: <RouteBase>[

    GoRoute(
        path: Routes.primary,
      builder: (BuildContext context, GoRouterState state){
          return const NavigationScreen();
      }
    ),

    GoRoute(
      path: Routes.auth,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen();
      },
    ),

    GoRoute(
      path: Routes.register,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),

    // Você pode adicionar rotas mais complexas aqui, se necessário.
  ],
);

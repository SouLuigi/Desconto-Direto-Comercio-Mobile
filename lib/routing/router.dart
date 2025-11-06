import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../ui/auth/widgets/auth_screen.dart';
import '../ui/register/widgets/register_screen.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.auth, // Iniciamos na tela de Login
  routes: <RouteBase>[
    // 1. Rota da Tela de Login
    GoRoute(
      path: Routes.auth,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen();
      },
    ),

    // 2. Rota da Tela de Cadastro
    GoRoute(
      path: Routes.register,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
    // Você pode adicionar rotas mais complexas aqui, se necessário.
  ],
);


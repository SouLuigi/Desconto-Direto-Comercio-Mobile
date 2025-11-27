import 'package:desconto_direto_comercio_mobile/ui/flyers/widgets/flyer_create_screen.dart';
import 'package:desconto_direto_comercio_mobile/ui/flyers/widgets/flyers_screen.dart';

import 'package:desconto_direto_comercio_mobile/ui/offer/widgets/offer_create_screen.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/widgets/offer_edit_screen.dart';
import 'package:desconto_direto_comercio_mobile/ui/profile/edit-profile-screen.dart';
import 'package:desconto_direto_comercio_mobile/ui/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../ui/Navigation/widget/navigation_screen.dart';
import '../ui/auth/widgets/auth_screen.dart';
import '../ui/register/widgets/register_screen.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.primary,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.primary,
      builder: (BuildContext context, GoRouterState state) {
        return const NavigationScreen();
      },
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
    GoRoute(
      path: Routes.flyers,
      builder: (BuildContext context, GoRouterState state) {
        return const FlyersScreen();
      },
    ),
    GoRoute(
      path: Routes.flyerscreate,
      builder: (BuildContext context, GoRouterState state) {
        return const FlyerCreateScreen();
      },
    ),

    GoRoute(
      path: Routes.profile,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: Routes.editProfile,
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfile();
      },
    ),

    GoRoute(
      path: Routes.offer,
      builder: (BuildContext context, GoRouterState state) {
        return const OfferCreateScreen();
      },
    ),

    GoRoute(
      path: Routes.offer_edit,
      builder: (BuildContext context, GoRouterState state) {
        return const OfferEditScreen();
      },
    ),

   

    // Você pode adicionar rotas mais complexas aqui, se necessário.
  ],
);

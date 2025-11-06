// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:desconto_direto_comercio_mobile/ui/auth/view_models/auth_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/ui/auth/widgets/auth_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      // create: (_) => AuthViewModel(),
      // create: (_) => AuthViewModel(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: AuthScreen());
    // return MaterialApp(home: AuthScreen());
  }
}

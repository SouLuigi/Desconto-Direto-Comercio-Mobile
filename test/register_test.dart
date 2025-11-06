// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:desconto_direto_comercio_mobile/ui/register/view_models/register_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/ui/register/widgets/register_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegisterScreen());
  }
}

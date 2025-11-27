import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:desconto_direto_comercio_mobile/routing/router.dart';
import 'package:desconto_direto_comercio_mobile/ui/home/view_models/home_viewmodel.dart';

import 'package:desconto_direto_comercio_mobile/ui/offer/view_models/offer_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/data/services/offer_service.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/offer_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewmodel()),

        
        ChangeNotifierProvider(
          create: (_) => OfferViewModel(
            OfferService(
              OfferRepository(),   
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fluxo Auth/Register',
      routerConfig: appRouter,
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
    );
  }
}

import 'package:desconto_direto_comercio_mobile/routing/router.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'Fluxo Auth/Register',
      routerConfig: appRouter,
    );
  }
}
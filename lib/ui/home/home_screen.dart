import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:desconto_direto_comercio_mobile/ui/home/widgets/widget_card_offer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'view_models/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _commerceId = '2';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewmodel>(context, listen: false).loadOffers();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 47,
              color: AppColors.Yellow1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Minhas Ofertas',
                  style: GoogleFonts.kaiseiDecol(
                    textStyle: const TextStyle(
                      color: AppColors.White1,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Consumer<HomeViewmodel>(
                    builder: (context, viewModel, child){
                      if(viewModel.isLoading){
                        return const Center(child: CircularProgressIndicator());
                      }
                      if(viewModel.errorMessage != null){
                        return Center(
                          child: Text(
                            'Erro ao carregar ofertas: ${viewModel.errorMessage}',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      if (viewModel.offers.isEmpty) {
                        return const Center(child: Text('Nenhuma oferta disponível.'));
                      }
                      return ListView.builder(
                        itemCount: viewModel.offers.length,
                        itemBuilder: (context, index){
                          final offer = viewModel.offers[index];
                          return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                            child: WidgetCardOffer(offer: offer),
                          );
                        },
                      );
                    }
                )
            ),
          ],

        ),
      ),
    );
  }
}
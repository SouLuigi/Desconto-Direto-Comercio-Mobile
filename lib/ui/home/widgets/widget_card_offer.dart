import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product_model.dart' as widget;

class WidgetCardOffer extends StatelessWidget {
  const WidgetCardOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: AppColors.Orange1, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network()
            Text('Descrição'),
            Text('Validade'),
            Container(
              decoration: BoxDecoration(
                color: AppColors.Orange1,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Valor'),
                  InkWell(child: Icon(Icons.settings)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

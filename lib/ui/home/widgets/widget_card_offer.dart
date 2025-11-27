import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';

class WidgetCardOffer extends StatefulWidget {
  final Offer offer;

  const WidgetCardOffer({super.key, required this.offer});

  @override
  State<WidgetCardOffer> createState() => _WidgetCardOfferState();
}

class _WidgetCardOfferState extends State<WidgetCardOffer> {
  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;
    return SizedBox(
      width: 150,
      height: 240,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: AppColors.Orange1, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                offer.produto.fotoUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  // Exibe um ícone de erro se a imagem não puder ser carregada
                  return Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: AppColors.Orange1,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Text(
                offer.produto.nome.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Text(
                'Válido até: ${offer.validade.day}/${offer.validade.month}/${offer.validade.year}',
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.Orange1,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('R\$ ${offer.preco.toStringAsFixed(2)}'),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.settings,
                        color: AppColors.White1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/view_models/offer_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/routing/routes.dart';

class WidgetCardOffer extends StatefulWidget {
  final Offer offer;

  const WidgetCardOffer({super.key, required this.offer});

  @override
  State<WidgetCardOffer> createState() => _WidgetCardOfferState();
}

class _WidgetCardOfferState extends State<WidgetCardOffer> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;

    return SizedBox(
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: AppColors.Orange1, width: 2.5),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    offer.produto.fotoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
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
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    offer.produto.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${offer.produto.medida}${offer.produto.unidadeMedida}',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,),
                      child: Text(
                        'Oferta válida até: ${offer.validade.day}/${offer.validade.month}',
                        style: TextStyle(color: AppColors.Red1, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.Orange1,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'R\$ ${offer.preco.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.White1,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            showMenu = !showMenu;
                          }),
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

          if (showMenu)
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // BOTÃO EDITAR
                            GestureDetector(
                              onTap: () {
                                setState(() => showMenu = false);
                                context.read<OfferViewModel>().selectOffer(
                                  widget.offer,
                                );
                                context.push(Routes.offer_edit);
                              },
                              child: Container(
                                width: 140,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade600,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  "Editar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.White1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final vm = context.read<OfferViewModel>();
                                final ok = await vm.deleteOffer(
                                  widget.offer.id.toString(),
                                );

                                setState(() => showMenu = false);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      ok
                                          ? "Oferta excluída com sucesso!"
                                          : "Erro ao excluir a oferta",
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 140,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  "Excluir",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.White1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: GestureDetector(
                          onTap: () => setState(() => showMenu = !showMenu),
                          child: const Icon(
                            Icons.settings,
                            color: AppColors.White1,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/services/flutter_secure_storage.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/flyer_repository.dart';

import '../../../data/services/flyer_service.dart';


class FlyerViewModel {
  final FlyerService flyerService = FlyerService(FlyerRepository());
  final LocalStorageService storage = LocalStorageService();

  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<List<Flyer>> flyers = ValueNotifier([]);
  final ValueNotifier<String?> error = ValueNotifier(null);

  Future<void> carregarFlyers() async {
    loading.value = true;
    error.value = null;

    try {
      // 1️⃣ Pegando o ID do comércio logado
      final token = await storage.getToken();
      if (token == null) {
        throw Exception("Usuário não autenticado.");
      }
      final comercioIdLogado = int.parse(token);

      // 2️⃣ Carregando todos os panfletos da API
      final lista = await flyerService.getAllFlyers();

      // 3️⃣ Filtrando apenas panfletos desse comércio
      final listaFiltrada = lista.where((flyer) {
        return flyer.comercioId == comercioIdLogado;
      }).toList();

      // 4️⃣ Atualizando estado
      flyers.value = listaFiltrada;
    } catch (e) {
      error.value = e.toString();
    }

    loading.value = false;
  }

  Future<void> deletarFlyer(int id) async {
    try {
      await flyerService.deleteFlyer(id);
      flyers.value = flyers.value.where((f) => f.id != id).toList();
    } catch (e) {
      error.value = e.toString();
    }
  }
}

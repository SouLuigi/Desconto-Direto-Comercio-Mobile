import 'package:flutter/material.dart';
import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/flyer_repository.dart';
import '../../../data/services/flyer_service.dart';

class FlyerViewModel {
  final FlyerService flyerService = FlyerService(FlyerRepository());

  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<List<Flyer>> flyers = ValueNotifier([]);
  final ValueNotifier<String?> error = ValueNotifier(null);

  Future<void> carregarFlyers() async {
    loading.value = true;

    try {
      flyers.value = await flyerService.getAllFlyers();
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

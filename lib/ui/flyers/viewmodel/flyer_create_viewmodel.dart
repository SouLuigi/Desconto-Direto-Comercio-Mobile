import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/flyer_repository.dart';
import '../../../data/services/flyer_service.dart';
import 'package:desconto_direto_comercio_mobile/data/services/flutter_secure_storage.dart';

class FlyerCreateViewModel {
  final FlyerService flyerService = FlyerService(FlyerRepository());
  final LocalStorageService storage = LocalStorageService();

  final ValueNotifier<File?> imagemSelecionada = ValueNotifier(null);
  final ValueNotifier<DateTime?> dataExpiracao = ValueNotifier(null);
  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);

  Future<void> selecionarImagem() async {
    final ImagePicker picker = ImagePicker();

    final XFile? img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      imagemSelecionada.value = File(img.path);
    }
  }


  void selecionarData(DateTime data) {
    dataExpiracao.value = data;
  }

  Future<bool> salvarFlyer() async {
    if (imagemSelecionada.value == null ||
        dataExpiracao.value == null) {
      error.value = "Preencha todos os campos!";
      return false;
    }

    loading.value = true;

    try {
      final token = await storage.getToken();
      if (token == null) throw Exception("Usuário não autenticado.");

      final comercioId = int.parse(token);

      final flyer = Flyer(
        id: 0,
        fotoUrl: "temp",
        dataExpiracao: dataExpiracao.value!,
        comercioId: comercioId,
      );

      final criado = await flyerService.createNewFlyer(flyer);

      await flyerService.uploadImageOfFlyer(
        criado.id,
        imagemSelecionada.value!,
      );

      loading.value = false;
      return true;
    } catch (e) {
      loading.value = false;
      error.value = e.toString();
      return false;
    }
  }
}

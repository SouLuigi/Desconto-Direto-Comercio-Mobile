import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/model/product_model.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/services/product_service.dart';
import '../../../data/services/flutter_secure_storage.dart';

class ProductCreateViewModel {
  final ProductService service = ProductService(ProductRepository());
  final LocalStorageService storage = LocalStorageService();


  final ValueNotifier<File?> imagemSelecionada = ValueNotifier(null);
  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);


  String nome = "";
  String medida = "";
  String unidade = "";
  String categoria = "";


  Future<void> selecionarImagem() async {
    final ImagePicker picker = ImagePicker();

    final XFile? img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      imagemSelecionada.value = File(img.path);
    }
  }

  void setNome(String value) => nome = value;
  void setMedida(String value) => medida = value;
  void setUnidade(String value) => unidade = value;
  void setCategoria(String value) => categoria = value;


  Future<bool> salvarProduto() async {
    errorMessage.value = null;

    try {
      loading.value = true;


      if (nome.isEmpty || medida.isEmpty || unidade.isEmpty || categoria.isEmpty) {
        throw Exception("Preencha todos os campos.");
      }

      if (imagemSelecionada.value == null) {
        throw Exception("Selecione uma imagem do produto.");
      }


      final comercioId = int.tryParse(await storage.getToken() ?? "0") ?? 0;

      if (comercioId == 0) {
        throw Exception("Erro ao identificar o comércio.");
      }


      final produto = Product(
        id: 0,
        nome: nome,
        medida: medida,
        unidadeMedida: unidade,
        fotoUrl: "",
        categoria: categoria,
      );

      final result = await service.create(produto);

      await service.uploadImage(result.id.toString(), imagemSelecionada.value!);

      return true;

    } catch (e) {
      errorMessage.value = e.toString();
      return false;

    } finally {
      loading.value = false;
    }
  }
}

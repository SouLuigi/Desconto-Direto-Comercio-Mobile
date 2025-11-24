import 'dart:io';

import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/flyer_repository.dart';

class FlyerService {
  final FlyerRepository _repository;

  FlyerService(this._repository);

  Future<Flyer> createNewFlyer(Flyer flyer) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expirationDate = DateTime(
      flyer.dataExpiracao.year,
      flyer.dataExpiracao.month,
      flyer.dataExpiracao.day,
    );

    if (expirationDate.isBefore(today) ||
        flyer.fotoUrl.isEmpty ||
        flyer.comercioId <= 0) {
      throw Exception("Dados inválidos para registro.");
    }
    try {
      final jsonResponse = await _repository.create(flyer);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Flyer>> getAllFlyers() async {
    try {
      final jsonResponse = await _repository.getAll();
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Flyer> getFlyerById(String id) async {
    try {
      final jsonResponse = await _repository.getById(id);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFlyer(String id) async {
    try {
      final jsonResponse = await _repository.delete(id);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> uploadImageOfFlyer(String id, File image) async {
    try {
      await _repository.uploadImage(id, image);
      return true;
    } catch (e) {
      print('Erro ao salvar foto no repository: $e');
      return false;
    }
  }
}

/*
  Este código foi criado por Otávio T. F. da Cunha
  Em 11/04/2024 - Para a atividade técnica da Objective.
*/

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:herois_marvel/models/marvel_model.dart';
import 'package:herois_marvel/repositories/custom_dio.dart';

class PersonagensRepository {
  final _customDio = CustomDio();

  PersonagensRepository();

  Future<MarvelPersonagemModel> listarPersonagens({int page = 1}) async {
    var url = "${dotenv.get("BASE_URL_MARVEL")}/v1/public/characters";
    var result = await _customDio.dio
        .get(url, queryParameters: {'offset': (page - 1) * 4});
    return MarvelPersonagemModel.fromJson(result.data);
  }

  Future<MarvelPersonagemModel> listarPersonagem(String nameStartsWith,
      {int page = 1}) async {
    var url = "${dotenv.get("BASE_URL_MARVEL")}/v1/public/characters";
    var result = await _customDio.dio.get(url, queryParameters: {
      'nameStartsWith': nameStartsWith,
      'offset': (page - 1) * 4
    });
    return MarvelPersonagemModel.fromJson(result.data);
  }
}

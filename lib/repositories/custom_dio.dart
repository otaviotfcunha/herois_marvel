/*
  Este código foi criado por Otávio T. F. da Cunha
  Em 11/04/2024 - Para a atividade técnica da Objective.
*/

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:herois_marvel/repositories/dio_interceptor.dart';

class CustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  CustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BASE_URL_MARVEL");
    _dio.interceptors.add(MarvelInterceptor());
  }
}

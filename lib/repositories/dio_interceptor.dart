import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:crypto/crypto.dart';

class MarvelInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final publicKey = dotenv.get("APPRESTAPI_PUBLICKEY_MARVEL");
    final privateKey = dotenv.get("APPRESTAPI_PRIVATEKEY_MARVEL");
    final hash = generateMd5('$timestamp$privateKey$publicKey');

    options.queryParameters.addAll(
        {'apikey': publicKey, 'ts': timestamp, 'hash': hash, 'limit': 4});

    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  // Função para gerar o hash MD5
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}

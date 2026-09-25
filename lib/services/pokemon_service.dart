import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokemonNaoEncontradoException implements Exception {
  @override
  String toString() => 'Pokemon nao encontrado.';
}

class FalhaConexaoException implements Exception {
  @override
  String toString() => 'Nao foi possivel conectar a API. Verifique sua internet.';
}

class RespostaInvalidaException implements Exception {
  @override
  String toString() => 'A API retornou dados invalidos ou incompletos.';
}

class ErroApiException implements Exception {
  final int statusCode;

  ErroApiException(this.statusCode);

  @override
  String toString() => 'A API apresentou um erro interno (codigo $statusCode).';
}

class PokemonService {
  static const String _urlBase = 'https://pokeapi.co/api/v2/pokemon';

  Future<Pokemon> buscarPokemon(String nomeOuId) async {
    final consulta = nomeOuId.trim().toLowerCase();
    final uri = Uri.parse('$_urlBase/$consulta');

    late http.Response resposta;
    try {
      resposta = await http.get(uri).timeout(const Duration(seconds: 10));
    } on SocketException {
      throw FalhaConexaoException();
    } on TimeoutException {
      throw FalhaConexaoException();
    } on http.ClientException {
      throw FalhaConexaoException();
    }

    if (resposta.statusCode == 404) {
      throw PokemonNaoEncontradoException();
    }
    if (resposta.statusCode >= 400 && resposta.statusCode < 500) {
      throw Exception('A requisicao foi rejeitada pela API (codigo ${resposta.statusCode}).');
    }
    if (resposta.statusCode >= 500) {
      throw ErroApiException(resposta.statusCode);
    }
    if (resposta.statusCode != 200) {
      throw Exception('Resposta inesperada da API (codigo ${resposta.statusCode}).');
    }

    try {
      final dados = jsonDecode(resposta.body);
      if (dados is! Map<String, dynamic>) {
        throw RespostaInvalidaException();
      }
      return Pokemon.fromJson(dados);
    } on RespostaInvalidaException {
      rethrow;
    } on FormatException {
      throw RespostaInvalidaException();
    } on TypeError {
      throw RespostaInvalidaException();
    } on Exception {
      throw RespostaInvalidaException();
    }
  }
}

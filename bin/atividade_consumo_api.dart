import 'dart:io';

import 'package:atividade_consumo_api/models/pokemon.dart';
import 'package:atividade_consumo_api/services/pokemon_service.dart';

Future<void> main() async {
  final service = PokemonService();
  final historico = <String>[];
  var continuar = true;

  print('========================================');
  print('       CONSULTA DE POKEMON - POKEAPI');
  print('========================================');

  while (continuar) {
    _exibirMenu();
    stdout.write('Escolha uma opcao: ');
    final opcao = stdin.readLineSync()?.trim();

    switch (opcao) {
      case '1':
        await _consultarPokemon(service, historico);
      case '2':
        _exibirHistorico(historico);
      case '3':
        historico.clear();
        print('\nHistorico limpo com sucesso.');
      case '0':
        continuar = false;
        print('\nPrograma encerrado.');
      default:
        print('\nOpcao invalida. Escolha uma opcao do menu.');
    }
  }
}

void _exibirMenu() {
  print('\n----------------------------------------');
  print('1 - Consultar Pokemon');
  print('2 - Exibir historico');
  print('3 - Limpar historico');
  print('0 - Encerrar');
  print('----------------------------------------');
}

Future<void> _consultarPokemon(
  PokemonService service,
  List<String> historico,
) async {
  stdout.write('\nDigite o nome ou numero do Pokemon: ');
  final entrada = stdin.readLineSync()?.trim() ?? '';

  if (entrada.isEmpty) {
    print('Entrada vazia. Digite um nome ou numero valido.');
    return;
  }

  try {
    print('\nConsultando a API...');
    final pokemon = await service.buscarPokemon(entrada);
    historico.add(pokemon.nome);
    _exibirPokemon(pokemon);
  } catch (erro) {
    print('\nNao foi possivel realizar a consulta.');
    print(erro);
  }
}

void _exibirPokemon(Pokemon pokemon) {
  print('\nResultado da consulta');
  print('----------------------------------------');
  print('Numero: ${pokemon.id}');
  print('Nome: ${pokemon.nome.toUpperCase()}');
  print('Altura: ${pokemon.altura / 10} m');
  print('Peso: ${pokemon.peso / 10} kg');
  print('Tipos: ${pokemon.tipos.join(', ')}');
  print('Experiencia-base: ${pokemon.experienciaBase}');
  print('Especie: ${pokemon.especie}');
  print('Habilidades: ${pokemon.habilidades.join(', ')}');
  print('Estatisticas:');
  pokemon.estatisticas.forEach((nome, valor) {
    print('  - $nome: $valor');
  });
  print('Movimentos: ${pokemon.movimentos.join(', ')}');
  print('Imagem: ${pokemon.imagem}');
  print('----------------------------------------');
}

void _exibirHistorico(List<String> historico) {
  print('\nHistorico de consultas:');
  if (historico.isEmpty) {
    print('Nenhuma consulta realizada.');
    return;
  }

  for (var indice = 0; indice < historico.length; indice++) {
    print('${indice + 1}. ${historico[indice]}');
  }
}

# Atividade de Consumo de API com Dart

## Integrantes

## API escolhida

A aplicacao utiliza a **PokeAPI**, uma API publica que fornece dados sobre Pokemon sem necessidade de chave de acesso.

- URL base: `https://pokeapi.co/api/v2/`
- Endpoint utilizado: `GET https://pokeapi.co/api/v2/pokemon/{nome-ou-id}`

## Descricao

Esta aplicacao de linha de comando recebe o nome ou o numero de um Pokemon, faz uma requisicao HTTP para a PokeAPI, converte o JSON retornado em um objeto Dart e exibe os dados organizados no terminal.

O programa possui um menu que permanece em execucao ate o usuario escolher a opcao de encerramento.

## Instalacao

Requisitos:

- Dart SDK 3.0 ou superior;
- Acesso a internet para consultar a PokeAPI.

Na pasta do projeto, execute:

```bash
dart pub get
```

## Execucao

```bash
dart run
```

## Exemplo de consulta

```text
1 - Consultar Pokemon
2 - Exibir historico
3 - Limpar historico
0 - Encerrar

Escolha uma opcao: 1
Digite o nome ou numero do Pokemon: pikachu

Resultado da consulta
Numero: 25
Nome: PIKACHU
Altura: 0.4 m
Peso: 6.0 kg
Tipos: electric
Experiencia-base: 112
Especie: pikachu
Habilidades: static, lightning-rod
```

## Funcionalidades implementadas

- Menu interativo no terminal;
- Consulta por nome ou numero do Pokemon;
- Requisicao HTTP `GET` com o pacote `http`;
- Uso de `Future`, `async` e `await`;
- Conversao do JSON com `jsonDecode`;
- Modelo `Pokemon` com construtor `fromJson`;
- Exibicao de tipos, altura, peso, experiencia, especie, habilidades, estatisticas, movimentos e imagem;
- Mensagem para entrada vazia;
- Tratamento separado para Pokemon inexistente, falha de conexao, resposta invalida e erro da API;
- Historico das consultas realizadas;
- Opcao para limpar o historico;
- Possibilidade de realizar varias consultas na mesma execucao.

## Organizacao do projeto

```text
atividade-umf/
|-- bin/
|   `-- atividade_consumo_api.dart
|-- lib/
|   |-- models/
|   |   `-- pokemon.dart
|   `-- services/
|       `-- pokemon_service.dart
|-- pubspec.yaml
`-- README.md
```

## Dificuldades encontradas

A principal dificuldade foi tratar respostas diferentes da API de forma clara. Alem do codigo `404`, foi necessario distinguir falhas de conexao e tempo limite, JSON invalido e erros de servidor. Tambem foi necessario navegar por listas e objetos aninhados do JSON para montar o modelo `Pokemon`.

## Perguntas para reflexao

### 1. O que e uma API?

API e uma interface que define como um programa pode solicitar dados ou servicos de outro sistema. Ela permite a comunicacao entre aplicacoes por meio de regras e formatos definidos.

### 2. Qual e a funcao de uma requisicao HTTP?

Uma requisicao HTTP solicita uma operacao a um servidor. Neste projeto, o metodo `GET` solicita os dados de um Pokemon.

### 3. O que representa o codigo HTTP 200?

O codigo `200` indica que a requisicao foi processada com sucesso e que o servidor retornou uma resposta valida.

### 4. Qual e a diferenca entre os codigos 200, 400, 404 e 500?

- `200`: requisicao realizada com sucesso;
- `400`: requisicao invalida ou malformada;
- `404`: recurso solicitado nao foi encontrado;
- `500`: ocorreu um erro interno no servidor.

### 5. Por que utilizamos async e await?

Uma requisicao de rede pode demorar. `async` permite que a funcao trabalhe de forma assincrona, e `await` aguarda o resultado sem bloquear a organizacao do restante do fluxo com callbacks.

### 6. Qual e a funcao do metodo jsonDecode()?

`jsonDecode()` converte um texto no formato JSON em estruturas de dados do Dart, como mapas e listas.

### 7. Qual e a vantagem de converter o JSON para um objeto Dart?

O objeto organiza os dados em propriedades com nomes e tipos definidos. Isso facilita a leitura, a manutencao e o uso dos dados no restante do programa.

### 8. Por que devemos tratar excecoes ao consumir uma API?

A rede pode falhar, o servidor pode retornar erros e os dados podem estar diferentes do esperado. O tratamento de excecoes evita que o programa seja encerrado inesperadamente e permite informar o usuario de forma adequada.

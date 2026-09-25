class Pokemon {
  final int id;
  final String nome;
  final int altura;
  final int peso;
  final int experienciaBase;
  final String imagem;
  final List<String> tipos;
  final List<String> habilidades;
  final Map<String, int> estatisticas;
  final List<String> movimentos;
  final String especie;

  Pokemon({
    required this.id,
    required this.nome,
    required this.altura,
    required this.peso,
    required this.experienciaBase,
    required this.imagem,
    required this.tipos,
    required this.habilidades,
    required this.estatisticas,
    required this.movimentos,
    required this.especie,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final tiposJson = json['types'] as List<dynamic>? ?? [];
    final habilidadesJson = json['abilities'] as List<dynamic>? ?? [];
    final estatisticasJson = json['stats'] as List<dynamic>? ?? [];
    final movimentosJson = json['moves'] as List<dynamic>? ?? [];
    final sprites = json['sprites'] as Map<String, dynamic>? ?? {};
    final species = json['species'] as Map<String, dynamic>? ?? {};

    return Pokemon(
      id: _asInt(json['id']),
      nome: _asString(json['name']),
      altura: _asInt(json['height']),
      peso: _asInt(json['weight']),
      experienciaBase: _asInt(json['base_experience']),
      imagem: _asString(sprites['front_default'], fallback: 'Imagem indisponivel'),
      tipos: tiposJson
          .map((item) => _nestedName(item, 'type'))
          .where((name) => name.isNotEmpty)
          .toList(),
      habilidades: habilidadesJson
          .map((item) => _nestedName(item, 'ability'))
          .where((name) => name.isNotEmpty)
          .toList(),
      estatisticas: {
        for (final item in estatisticasJson)
          _nestedName(item, 'stat'): _asInt(item['base_stat']),
      }..removeWhere((name, _) => name.isEmpty),
      movimentos: movimentosJson
          .map((item) => _nestedName(item, 'move'))
          .where((name) => name.isNotEmpty)
          .take(10)
          .toList(),
      especie: _nestedName(species, 'name', directMap: true),
    );
  }

  static String _nestedName(
    dynamic item,
    String key, {
    bool directMap = false,
  }) {
    if (item is! Map<String, dynamic>) return '';
    final value = directMap ? item['name'] : item[key];
    if (value is Map<String, dynamic>) return _asString(value['name']);
    return _asString(value);
  }

  static String _asString(dynamic value, {String fallback = ''}) {
    return value?.toString() ?? fallback;
  }

  static int _asInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

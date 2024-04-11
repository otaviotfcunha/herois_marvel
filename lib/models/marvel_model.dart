/*
  Este código foi criado por Otávio T. F. da Cunha
  Em 11/04/2024 - Para a atividade técnica da Objective.
*/

class MarvelPersonagemModel {
  List<PersonagemData> results = [];
  int _quantidadeDados = 0;

  MarvelPersonagemModel(this.results);

  MarvelPersonagemModel.fromJson(Map<String, dynamic> json) {
    if (json['data']['results'] != null) {
      results = <PersonagemData>[];
      _quantidadeDados = json['data']['total'];

      json['data']['results'].forEach((v) {
        results.add(PersonagemData.fromJson(v));
      });
    }
  }

  MarvelPersonagemModel.fromJsonUnico(Map<String, dynamic> json) {
    results = <PersonagemData>[];
    results.add(PersonagemData.fromJson(json));
  }

  int get quantidadeDados => _quantidadeDados;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class PersonagemData {
  int id = 0;
  String nome = "";
  String descricao = "";
  String foto = "";
  int totalPages = 0;

  PersonagemData(
    this.nome,
    this.foto,
    this.descricao,
  );

  PersonagemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['name'].toString();
    foto =
        json['thumbnail']['path'] + "." + json['thumbnail']['extension'] ?? "";
    descricao = json['description'].toString();
    totalPages = json['totalPages'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['foto'] = this.foto;
    data['totalPages'] = this.totalPages;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['foto'] = this.foto;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

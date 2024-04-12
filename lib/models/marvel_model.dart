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
  List<String> series = [];
  List<String> eventos = [];
  int totalPages = 0;

  PersonagemData(
      this.nome, this.foto, this.descricao, this.series, this.eventos);

  PersonagemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['name'].toString();
    foto =
        json['thumbnail']['path'] + "." + json['thumbnail']['extension'] ?? "";
    descricao = json['description'].toString();
    totalPages = json['totalPages'] ?? 0;

    if (json['series']['items'] != null) {
      json['series']['items'].forEach((v) {
        series.add(v['name'].toString());
      });
    }
    if (json['events']['items'] != null) {
      json['events']['items'].forEach((v) {
        eventos.add(v['name'].toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.nome; // Corrigindo 'nome' para 'name'
    data['description'] =
        this.descricao; // Corrigindo 'descricao' para 'description'
    data['thumbnail'] = {'path': this.foto}; // Corrigindo 'foto' para 'path'
    data['totalPages'] = this.totalPages;
    data['series'] = this.series;
    data['events'] = this.eventos;
    return data;
  }
}

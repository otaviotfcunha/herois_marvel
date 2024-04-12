import 'package:flutter/material.dart';
import 'package:herois_marvel/const/colors.dart';
import 'package:herois_marvel/models/marvel_model.dart';
import 'package:herois_marvel/pages/personagem_page.dart';
import 'package:herois_marvel/repositories/marvel_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersonagensRepository _personagensRepository = PersonagensRepository();
  late MarvelPersonagemModel _characters = MarvelPersonagemModel([]);
  bool _loading = false;
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  String _buscaAtual = "";
  int _divisorTela = 1;
  double _porcentagemTela = 0.90;

  @override
  void initState() {
    super.initState();
    _buscarPersonagens();
  }

  Future<void> _buscarPersonagens({String? texto}) async {
    if (_buscaAtual != "") {
      texto = _buscaAtual;
    }

    setState(() {
      _loading = true;
    });
    try {
      final result = texto != null ? await _personagensRepository.listarPersonagem(texto, page: _currentPage) : await _personagensRepository.listarPersonagens(page: _currentPage);
      setState(() {
        _characters = result;
        _loading = false;
      });
    } catch (e) {
      print('Erro ao buscar personagens: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _buscarPersonagens();
    }
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
    });
    _buscarPersonagens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.secondaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorsApp.primaryColor,
                    width: 3.0,
                  ),
                ),
              ),
              child: const Text(
                "BUSCA",
                style: TextStyle(
                  color: ColorsApp.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 9),
              child: const Text(
                " MARVEL",
                style: TextStyle(
                  color: ColorsApp.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 9),
              child: const Text(
                " TESTE FRONT-END",
                style: TextStyle(
                  color: ColorsApp.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
        actions: [
          LayoutBuilder(
            builder: (context, constraints) {
              var tamanho = MediaQuery.of(context).size;
              if (tamanho.width > 600) {
                return Container(
                  padding: const EdgeInsets.only(right: 20, bottom: 9),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "OTAVIO T. F. CUNHA",
                    style: TextStyle(
                      color: ColorsApp.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(color: ColorsApp.secondaryColor),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text(
                          "Nome do Personagem",
                          style: TextStyle(color: ColorsApp.primaryColor, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    width: 320,
                    child: TextFormField(
                      onChanged: (value) {
                        _buscaAtual = value;
                        _currentPage = 1;
                        if (value == "") {
                          _buscarPersonagens();
                        } else {
                          _buscarPersonagens(texto: value);
                        }
                      },
                      controller: _searchController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: ColorsApp.textColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  color: ColorsApp.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    height: 40,
                    width: double.parse(MediaQuery.of(context).size.width.toString()) * _porcentagemTela / _divisorTela,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 100),
                          child: Text(
                            "Nome",
                            style: TextStyle(color: ColorsApp.secondaryColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    var tamanhoInterno = MediaQuery.of(context).size;
                    if (tamanhoInterno.width > 600) {
                      if (tamanhoInterno.width > 1200) {
                        _porcentagemTela = 0.93;
                      } else if (tamanhoInterno.width > 1500) {
                        _porcentagemTela = 0.96;
                      } else {
                        _porcentagemTela = 0.91;
                      }
                      _divisorTela = 3;
                      return Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: ColorsApp.primaryColor,
                            width: double.parse(MediaQuery.of(context).size.width.toString()) * _porcentagemTela / _divisorTela,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: const SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text(
                                      "Séries",
                                      style: TextStyle(
                                        color: ColorsApp.secondaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: ColorsApp.primaryColor,
                            width: double.parse(MediaQuery.of(context).size.width.toString()) * _porcentagemTela / _divisorTela,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: const SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text(
                                      "Eventos",
                                      style: TextStyle(
                                        color: ColorsApp.secondaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      _divisorTela = 1;
                      _porcentagemTela = 0.90;
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _characters.results.length,
                      itemBuilder: (context, index) {
                        final character = _characters.results[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersonagemPage(character: character),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 42,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: 58,
                                        height: 58,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: character.foto.isNotEmpty
                                                ? Image.network(
                                                    character.foto,
                                                    fit: BoxFit.cover,
                                                  )
                                                : const CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        width: double.parse(MediaQuery.of(context).size.width.toString()) * _porcentagemTela / _divisorTela,
                                        child: Text(
                                          character.nome,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: ColorsApp.textColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        var tamanhoInterno = MediaQuery.of(context).size;
                                        if (tamanhoInterno.width > 600) {
                                          String mostraSeries = "";
                                          for (var serie in character.series) {
                                            mostraSeries += "\n $serie";
                                          }
                                          return Expanded(
                                            flex: 4,
                                            child: Container(
                                              width: double.parse(MediaQuery.of(context).size.width.toString()) * _porcentagemTela / _divisorTela,
                                              child: Text(
                                                mostraSeries.trim(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: ColorsApp.textColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        var tamanhoInterno = MediaQuery.of(context).size;
                                        if (tamanhoInterno.width > 600) {
                                          String mostraEventos = "";
                                          for (var evento in character.eventos) {
                                            mostraEventos += "\n $evento";
                                          }
                                          return Expanded(
                                            flex: 4,
                                            child: Container(
                                              width: double.parse(MediaQuery.of(context).size.width.toString()) * _porcentagemTela / _divisorTela,
                                              child: Text(
                                                mostraEventos.trim(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: ColorsApp.textColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: ColorsApp.primaryColor,
                                height: 1,
                                thickness: 2,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_currentPage > 1) ...[
                    ElevatedButton(
                      onPressed: _previousPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.secondaryColor,
                        elevation: 0,
                        shape: const CircleBorder(
                          side: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_left_sharp,
                        color: ColorsApp.primaryColor,
                        size: 40,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _goToPage(_currentPage - 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.secondaryColor,
                        elevation: 0,
                        shape: const CircleBorder(
                          side: BorderSide(color: ColorsApp.primaryColor),
                        ),
                      ),
                      child: Text(
                        '${_currentPage - 1}',
                        style: const TextStyle(
                          color: ColorsApp.primaryColor,
                        ),
                      ),
                    ),
                  ],
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.primaryColor,
                      elevation: 0,
                      shape: const CircleBorder(),
                    ),
                    child: Text(
                      '$_currentPage',
                      style: const TextStyle(
                        color: ColorsApp.secondaryColor,
                      ),
                    ),
                  ),
                  if (_currentPage < _characters.quantidadeDados) ...[
                    ElevatedButton(
                      onPressed: () => _goToPage(_currentPage + 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.secondaryColor,
                        elevation: 0,
                        shape: const CircleBorder(
                          side: BorderSide(color: ColorsApp.primaryColor),
                        ),
                      ),
                      child: Text(
                        '${_currentPage + 1}',
                        style: const TextStyle(
                          color: ColorsApp.primaryColor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.secondaryColor,
                        elevation: 0,
                        shape: const CircleBorder(
                          side: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_right_sharp,
                        color: ColorsApp.primaryColor,
                        size: 40,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToPage(int page, {String? texto}) {
    setState(() {
      _currentPage = page;
    });
    _buscarPersonagens(texto: texto);
  }
}

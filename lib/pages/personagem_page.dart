/*
  Este código foi criado por Otávio T. F. da Cunha
  Em 11/04/2024 - Para a atividade técnica da Objective.
*/

import 'package:flutter/material.dart';
import 'package:herois_marvel/const/colors.dart';
import 'package:herois_marvel/models/marvel_model.dart';

class PersonagemPage extends StatefulWidget {
  final PersonagemData character;

  const PersonagemPage({Key? key, required this.character}) : super(key: key);

  @override
  State<PersonagemPage> createState() => _PersonagemPageState();
}

class _PersonagemPageState extends State<PersonagemPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsApp.primaryColor,
          title: Text(
            widget.character.nome,
            style: const TextStyle(color: ColorsApp.secondaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  kToolbarHeight -
                  kBottomNavigationBarHeight -
                  16.0,
            ),
            color: ColorsApp.secondaryColor,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.character.foto,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Divider(color: ColorsApp.primaryColor),
                const SizedBox(height: 16.0),
                Text(
                  widget.character.descricao.isNotEmpty
                      ? widget.character.descricao
                      : "Este personagem não tem descrição cadastrada.",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: ColorsApp.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: ColorsApp.primaryColor,
          child: const Icon(
            Icons.close,
            color: ColorsApp.secondaryColor,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

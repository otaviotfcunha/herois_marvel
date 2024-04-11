/*
  Este código foi criado por Otávio T. F. da Cunha
  Em 11/04/2024 - Para a atividade técnica da Objective.
*/

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:herois_marvel/my_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

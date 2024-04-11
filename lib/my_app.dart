/*
  Este código foi criado por Otávio T. F. da Cunha
  Em 11/04/2024 - Para a atividade técnica da Objective.
*/

import 'package:flutter/material.dart';
import 'package:herois_marvel/const/colors.dart';
import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorsApp.primaryColor,
        fontFamily: 'Roboto-Black',
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorsApp.secondaryColor,
        ),
      ),
      home: HomePage(),
    );
  }
}

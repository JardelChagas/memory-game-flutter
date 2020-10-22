import 'package:flutter/material.dart';
import 'package:memory_game/screens/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jogo da Memoria",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

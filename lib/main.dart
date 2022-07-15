import 'package:flutter/material.dart';
import 'package:pokedex/home_screen.dart';

// This means that it will run the main of the app but as a function
void main(){
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}


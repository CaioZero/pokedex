import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatefulWidget {

  final pokemonDetail;
  final Color color;
  final int heroTag;

  const PokemonDetailScreen({Key? key, required this.pokemonDetail, required this.color, required this.heroTag}) : super(key: key);
  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.color,
     body: Stack(
       alignment: Alignment.center,
       children: [
         //arrow back
         Positioned(
           top: 20,
           left: 0,
           child: IconButton(onPressed: (){
             Navigator.pop(context);
           }, icon: const Icon(Icons.arrow_back, color: Colors.white, size: 50)),
         ),
         //Pokemon Name
         Positioned(
             top: 100,
             left: 20,
             child: Text(widget.pokemonDetail['name'],
             style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
             ),
             )
         ),
         // Pokemon Types
         Positioned(
             top: 150,
             left: 20,
             child: Container(
               decoration: const BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(20),),
                   color: Colors.black26
               ),
               child: Padding(
                 padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4, bottom: 4),
                 child: Text(widget.pokemonDetail['type'].join(', '),
                   style: const TextStyle(
                   color: Colors.white,
                     fontWeight: FontWeight.bold,
                     fontSize: 16
                 ),),
               ),
             ),
         ),
         //Pokeball Background
         Positioned(
             top: height * 0.2,
             right: 10,
             child: Image.asset('images/pokeball.png', height: 200, fit: BoxFit.fitHeight,)
         ),
         //Pokemon Details
         Positioned(
           bottom: 0,
           child: Container(
             width: width,
             height: height * 0.6,
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
               color: Colors.white,
             ),
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   const SizedBox(height: 30,),
                   createDetails('Name',width, widget.pokemonDetail['name']),
                   createDetails('Height',width, widget.pokemonDetail['height']),
                   createDetails('Weight',width, widget.pokemonDetail['weight']),
                   createDetails('Spawn Time',width, widget.pokemonDetail['spawn_time']),
                   createDetailsList('Weaknesses',width, widget.pokemonDetail['weaknesses']),
                   createNextEvolutionList('Evolution',width, widget),
                   createPreviousEvolutionList('Pre Form',width, widget),
                 ],
               ),
             ),
           ),
         ),
         //Pokemon Image
         Positioned(
             top: height * 0.2,
             left:( width / 2) - 100,
             child: CachedNetworkImage(
           imageUrl: widget.pokemonDetail['img'],
               height: 200,
               fit: BoxFit.fitHeight,
         ))
       ],
     ),
    );
  }

}

createPreviousEvolutionList(String details, double width, widget) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          SizedBox(
            width: width * 0.3,
            child: Text(
              details,
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20
              ),),
          ),
          widget.pokemonDetail['prev_evolution'] != null ?
          SizedBox(
            height: 20,
            width: width * 0.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:  widget.pokemonDetail['prev_evolution'].length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(widget.pokemonDetail['prev_evolution'][index]['name'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                );
              },
            ),
          ) : const Text('Just Hatched',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            ) ,),
        ]),
  );
}

createNextEvolutionList(String details, double width, widget) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          SizedBox(
            width: width * 0.3,
            child: Text(
              details,
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20
              ),),
          ),
          widget.pokemonDetail['next_evolution'] != null ?
          SizedBox(
            height: 20,
              width: width * 0.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:  widget.pokemonDetail['next_evolution'].length,
                itemBuilder: (context,index){
                  return Padding(
                      padding: const EdgeInsets.only(right: 8),
                    child: Text(widget.pokemonDetail['next_evolution'][index]['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                  );
                },
              ),
          ) : const Text('Maxed out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ) ,),
        ]),
  );
}

createDetailsList(String details, double width, pokedexData) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          SizedBox(
            width: width * 0.3,
            child: Text(
              details,
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20
              ),),
          ),
          SizedBox(
              child: Text(pokedexData.join(", "),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),)
          ),
        ]),
  );
}

createDetails(details, double width, pokedexData) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          SizedBox(
            width: width * 0.3,
            child: Text(
              details,
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20
              ),),
          ),
          SizedBox(
              width: width * 0.3,
              child: Text(pokedexData,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),)
          ),
        ]),
  );
}





import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon_detaill_screen.dart';

// Homescreen to be claimed
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeAPi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List pokedex = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Check if the view has been mounted
    if(mounted) fetchPokemonData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children:[
          //Pokebola do titulo
          Positioned(
            top: -50,
              right: -50,
              child: Image.asset('images/pokeball.png', width: 200, fit: BoxFit.fitWidth,)
          ),
       const Positioned(
             top: 100,
              left: 20,
              child: Text(
                'Pokedex',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
              )
          ),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
            children: [
              //Grid View Cria uma grade de visuaisNotEmpty
              pokedex.isNotEmpty ? Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               // Numero de grades
                crossAxisCount: 2,
                //Tamanho de cada view dentro do grid
                childAspectRatio: 1.4,
              ),
                //Quantos itens possuem
                itemCount: pokedex.length,
              itemBuilder: (context, index){
                var type = pokedex[index]['type'][0];
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    child: Container(
                      //Style do box
                      decoration: BoxDecoration(
                        color: colorType(type),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Stack(
                        //Aqui vale pra cada item da lista (a lista é a pokedex)
                        children: [
                          Positioned(
                              bottom: -10,
                              right: -10,
                              child: Image.asset('images/pokeball.png',
                                height: 100, fit:
                                BoxFit.fitHeight,)),

                          //Pokemon Image
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: CachedNetworkImage(
                                imageUrl: pokedex[index]['img'],
                                height: 100,
                                fit: BoxFit.fitWidth
                            ),
                          ),

                          //Pokemon Name
                          Positioned(
                                top: 20,
                                left: 10,
                                child: Text(
                                pokedex[index]['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18,
                                    color: Colors.white
                                  ) ,
                                ),
                              ),

                          //Pokemon Type

                          Positioned(
                            top: 45,
                            left: 20,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.black26,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                                child: Text(
                                  type.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> PokemonDetailScreen(
                      pokemonDetail: pokedex[index],
                      color: colorType(type),
                      heroTag: index,
                    )));
                    //Navigate to new detail screen
                    },
                );
                },
              )
              ) : const Center(
                //If the pokedex comes null
                child: CircularProgressIndicator() ,
              )
            ],
        ),
          ),
    ]
      )
    );
  }

  void fetchPokemonData() {
    var url = Uri.https("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if(value.statusCode == 200){
        var decodedValue = jsonDecode(value.body);
        pokedex = decodedValue['pokemon'];
        setState((){
        });
      }
    });
  }

  colorType(type){
    switch(type){
      case 'Grass':
        return Colors.greenAccent;
      case 'Fire':
        return Colors.redAccent;
      case 'Water':
        return Colors.blueAccent;
      case 'Bug':
        return Colors.green;
      case 'Ghost':
        return Colors.purple;
      case 'Poison':
        return Colors.deepPurpleAccent;
      case 'Ground':
        return Colors.brown;
      case 'Psychic':
        return Colors.indigo;
      case 'Electric':
        return Colors.yellowAccent;
      case 'Rock':
        return Colors.grey;
      case 'Fighting':
        return Colors.orange;
      default:
        return Colors.amber;
    }
  }
}

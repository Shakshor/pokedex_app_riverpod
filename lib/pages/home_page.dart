import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_with_riverpod/controllers/home_page_controller.dart';
import 'package:pokedex_with_riverpod/models/page_data.dart';
import 'package:pokedex_with_riverpod/models/pokemon.dart';
import 'package:pokedex_with_riverpod/widgets/pokemon_list_tile.dart';

final homePageControllerProvider = StateNotifierProvider<HomePageController, HomePageData>((ref){
  return HomePageController(
      HomePageData.initial(), // initial_data_should_be_given
  );
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late  HomePageController _homePageController;
  late  HomePageData _homePageData;

  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);
    Size size = MediaQuery.of(context).size;
    // Size size = MediaQuery.sizeOf(context);

    return  Scaffold(
      body: _buildUI(
        context,
        size,
      ),
    );
  }

  // build_ui
  Widget _buildUI(
      BuildContext context,
      Size size) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _allPokemonsList(context, size),
            ],
          ),
        ),
      ),
    );
  }

  // all_pokemons_widget
  Widget _allPokemonsList(
      BuildContext context,
      Size size,
      ){
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'All Pokemons',
            style: TextStyle(
              fontSize: 25,
            ),
          ),


          SizedBox(
            // var data = _homePageData.data?.results?.length;
            // log('$data');
            height: size.height * 0.60,
            child: ListView.builder(
                itemCount: _homePageData.data?.results?.length ?? 0,
                itemBuilder: (context, index){
                  PokemonListResult pokemon = _homePageData.data!.results![index];

                  // return ListTile(
                  //   title: Text(index.toString()),
                  // );
                  return PokemonListTile(
                      pokemonUrl: pokemon.url!,
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_with_riverpod/providers/pokemon_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../models/pokemon.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonUrl;

  const PokemonListTile({
    super.key,
    required this.pokemonUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));

    return pokemon.when(
        data: (data){
          return _tile(
            context,
            false,
            data,
          );
        },
        error: (error, stackTrace){
          return Text('Error: $error');
        },
        loading: (){
          return _tile(
              context,
              true,
              null,
          );
        }
    );


  }

  Widget _tile(
      BuildContext context,
      bool isLoading,
      Pokemon? pokemon,
      ){
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        title: Text(pokemon != null ? pokemon.name!.toUpperCase() : 'loading name'),
      ),
    );
  }
}

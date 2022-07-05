//
//  Manager.swift
//  pokedexmvp
//
//  Created by Maxim on 02.07.2022.
//

import Foundation

class Manager {
    let service = NetworkService()

    func getPokemonsFromServer(handle: @escaping(NetworkResponce)) {
        service.fetchPokemon { pokemons in
            handle(pokemons)
        }
    }

    func getImageAndDescription(url: String, handle: @escaping((Description) -> Void)) {
        service.fetchPokemonInfo(url: url) { pokemonInfo in
            DispatchQueue(label: "my.queue").async {

                guard let imageURL = URL(string: pokemonInfo.sprites.frontDefault) else {return}
                guard let imageData = try? Data(contentsOf: imageURL) else {return}
                _ = pokemonInfo.types
                let description = Description(name: pokemonInfo.name,
                                              weight: pokemonInfo.weight,
                                              height: pokemonInfo.height,
                                              types: pokemonInfo.types,
                                              image: imageData)

                DispatchQueue.main.async {
                    handle(description)
                }
            }
        }
    }
}

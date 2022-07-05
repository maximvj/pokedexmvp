//
//  ViewModel.swift
//  pokedexmvp
//
//  Created by Maxim on 02.07.2022.
//

import Foundation

// MARK: - Protocols

protocol ViewModelProtocol: AnyObject {
    func getPokemons()
    var delegate: ViewModelDelegate? { get set }
    var pokemonDescription: [String: Description] { get set }
}

protocol ViewModelDelegate: AnyObject {
    func updatePokemons(by index: Int, with imageData: Data?)
    func getAllPokemon(pokemons: [String])
}

// MARK: - Classes

class ViewModel: ViewModelProtocol {

    // MARK: - Properties

    weak var delegate: ViewModelDelegate?
    var manager = Manager()
    var fullPokemonInfo: [Result] = []
    var pokemonDescription: [String: Description] = [:]
    var pokemonNames: [String] {
        fullPokemonInfo.map {$0.name}
    }

    // MARK: - Methods

    func getPokemons() {
        manager.getPokemonsFromServer { [weak self] response in
            self?.fullPokemonInfo = response
            self?.delegate?.getAllPokemon(pokemons: self?.pokemonNames ?? [String]())

            self?.fullPokemonInfo.forEach { [weak self] element in
                self?.updatePokemon(by: element.name, url: element.url)
            }
        }
    }

    private func updatePokemon(by name: String, url: String) {
        if let image = pokemonDescription[name]?.image,
           let index = fullPokemonInfo.firstIndex(where: { $0.name == name}) {
            delegate?.updatePokemons(by: index, with: image)
            return
        }

        manager.getImageAndDescription(url: url ) { description  in
            let imageData = description.image
            self.pokemonDescription[name] = description

            if let index = self.fullPokemonInfo.firstIndex(where: {$0.name == name}) {
                self.delegate?.updatePokemons(by: index, with: imageData)
            }
        }
    }
}

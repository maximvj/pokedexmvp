//
//  Service.swift
//  pokedexmvp
//
//  Created by Maxim on 02.07.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchPokemon(completionHandler: @escaping NetworkResponce)
}

typealias NetworkResponce = ([Result]) -> Void

class NetworkService: NetworkServiceProtocol {
    static var shared = NetworkService()

    func fetchPokemon(completionHandler: @escaping NetworkResponce) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=300"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            if let completion = self.parseJSON(withData: data) {
                completionHandler(completion)
            }
        } .resume()
    }

    func fetchPokemonInfo(url: String, completion: @escaping (PokemonInfo) -> Void) {
        let urlString = url
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            if  let pokemonSprite = try? JSONDecoder().decode(PokemonInfo.self, from: data) {
                completion(pokemonSprite)
            }
        } .resume()
    }

    func parseJSON(withData data: Data) -> [Result]? {
        let decoder = JSONDecoder()
        do {
            let networkData = try decoder.decode(PokemonData.self, from: data)
            return networkData.results
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

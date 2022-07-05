//
//  Person.swift
//  pokedexmvp
//
//  Created by Maxim on 02.07.2022.
//

import Foundation

struct PokemonData: Codable {
    let results: [Result]
}

struct Result: Codable {
    let name: String
    let url: String
}

struct PokemonInfo: Codable {
    let name: String
    let sprites: PokemonSprites
    let weight: Int
    let height: Int
    let types: [TypeElement]

    enum CodingKeys: String, CodingKey {
        case name
        case height
        case sprites, weight, types
    }
}

struct Species: Codable {
    let name: String
    let url: String
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}

struct PokemonSprites: Codable {
    var frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

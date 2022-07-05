//
//  DescriptionModel.swift
//  pokedexmvp
//
//  Created by Maxim on 02.07.2022.
//

import Foundation

struct Description {
    let name: String
    let weight: Int
    let height: Int
    let types: [TypeElement]
    var image: Data
    var typeString: String {
        types.map({$0.type.name.capitalized}).joined(separator: ", ")
    }
    var weightKiloString: String {
        let weightKilo = Double(weight) * 0.10
        return String(format: "%.1f", weightKilo)
    }
    var heighMeterString: String {
        let heighMeter = Double(height) * 0.10
        return String(format: "%.1f", heighMeter)
    }
}

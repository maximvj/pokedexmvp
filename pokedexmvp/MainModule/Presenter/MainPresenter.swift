//
//  MainPresenter.swift
//  1 - MVP
//
//  Created by Maxim on 02.06.2022.
//

import Foundation

// MARK: - Protocols

protocol  MainViewProtocol: AnyObject {
    func reloadData()
    func failure()
    func update (by index: Int, with imageData: Data?)
}

protocol  MainViewPresenterProtocol: AnyObject {
    var pokemonsNames: [String]? {get set}
    var filteredPokemonsNames: [String]? {get set}
    var pokemonsDescription: [String: Description]? {get set}

    init(view: MainViewProtocol, router: RouterProtocol, viewModel: ViewModelProtocol)

    func tapOnPokemon(description: Description)
    func filterSearchResults(presenter: MainViewPresenterProtocol?, searchText: String)

}

// MARK: - Classes

class MainPresenter: MainViewPresenterProtocol {

    // MARK: - Properties
    
    weak var view: MainViewProtocol?
    var viewModel: ViewModelProtocol?
    var router: RouterProtocol?
    var pokemonsNames: [String]?
    var filteredPokemonsNames: [String]?
    var pokemonsDescription: [String: Description]?

    // MARK: - Init
    
    required init(view: MainViewProtocol, router: RouterProtocol, viewModel: ViewModelProtocol) {
        self.view = view
        self.viewModel = viewModel
        self.router = router
        self.viewModel?.delegate = self

        viewModel.getPokemons()
    }

    // MARK: - Methods
    
    func tapOnPokemon(description: Description) {
        router?.showDescription(description: description)
    }

    func filterSearchResults(presenter: MainViewPresenterProtocol?, searchText: String) {
        let pokemonsNames = presenter?.pokemonsNames

        guard !searchText.isEmpty else {
            presenter?.filteredPokemonsNames = pokemonsNames
            self.view?.reloadData()
            return
        }

        presenter?.filteredPokemonsNames = pokemonsNames?.filter({ pokemon in
            pokemon.lowercased().contains(searchText.lowercased())
        })

        self.view?.reloadData()
    }
}

// MARK: - Extension ViewModelDelegate

extension MainPresenter: ViewModelDelegate {
    func updatePokemons(by index: Int, with imageData: Data?) {
        guard let imageData = imageData else { return }
        self.pokemonsDescription = viewModel?.pokemonDescription
        self.view?.update(by: index, with: imageData)
    }

    func getAllPokemon(pokemons: [String]) {
        self.pokemonsNames = pokemons
        self.filteredPokemonsNames = pokemonsNames

        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }

}

import XCTest
@testable import pokedexmvp

class PokedexmvpTests: XCTestCase {

    var view: MainViewProtocol = MockView()
    var viewModel: ViewModelProtocol = MockViewModel()
    var service: NetworkServiceProtocol = MockService()
    var router: RouterProtocol = MockRouter()


    func testGetSuccessFetchPokemon() {
        _ = MainPresenter(view: view, router: router, viewModel: viewModel)
        if let viewModel = viewModel as? MockViewModel {
            XCTAssert(viewModel.results)
        }
    }

}

class MockView: MainViewProtocol {
    func reloadData() { }

    func failure() { }

    func update(by index: Int, with imageData: Data?) { }

}

class MockViewModel: ViewModelProtocol {
    var results: Bool = false

    func getPokemons() {
        results = true
    }

    var delegate: ViewModelDelegate?

    var pokemonDescription: [String: Description] = [:]
}

class MockRouter: RouterProtocol {
    func startViewController() {}

    func showDescription(description: Description?) {}

    func popToRoot() {}

    var navigationController: UINavigationController?

    var assemblyBuilder: AssemblyBuilderProtocol?
}

class MockService: NetworkServiceProtocol {
    func fetchPokemonInfo(url: String, completion: @escaping (PokemonInfo) -> Void) {}
    func fetchPokemon(completionHandler: @escaping NetworkResponce) {
    }
}

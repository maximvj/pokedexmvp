//
//  RouterTEst.swift
//  pokedexmvpTests
//
//  Created by Maxim on 04.07.2022.
//

import XCTest
@testable import pokedexmvp

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.presentedVC = viewControllerToPresent
        super.present(viewControllerToPresent, animated: true, completion: nil)
    }
}

class RouterTest: XCTestCase {

    var router: RouterProtocol?
    var navigationController = MockNavigationController()
    let assembly = AssemblyBuilder()

    override func setUpWithError() throws {
        try super.setUpWithError()
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        router = nil
    }

    func testRouter() {
        let description = Description(name: "", weight: 0, height: 0, types: [], image: Data())
        router?.showDescription(description: description)
        let descriptionViewConroler = navigationController.presentedVC
        XCTAssertTrue(descriptionViewConroler is DescriptionViewController)
    }
}

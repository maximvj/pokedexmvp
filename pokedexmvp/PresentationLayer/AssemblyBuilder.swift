//
//  Builder.swift
//  mvppokemonproject
//
//  Created by Maxim on 07.06.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDescriptionModule(description: Description, router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let viewModel = ViewModel()
        let presenter = MainPresenter(view: view, router: router, viewModel: viewModel)
        view.presenter = presenter
        return view
    }

    func createDescriptionModule(description: Description, router: RouterProtocol) -> UIViewController {
        let view = DescriptionViewController()
        let presenter = DescriptionPresenter(view: view, router: router, description: description)
        view.presenter = presenter
        return view
    }

}

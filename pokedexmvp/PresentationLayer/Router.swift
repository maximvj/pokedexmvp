//
//  RouterProtocol.swift
//  mvppokemonproject
//
//  Created by Maxim on 30.06.2022.
//

import Foundation

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: AssemblyBuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMain {
    func startViewController()
    func showDescription(description: Description?)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func startViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else {return}
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showDescription(description: Description?) {
        if let navigationController = navigationController, let description = description {
            guard let descriptionViewController = assemblyBuilder?.createDescriptionModule(description: description, router: self) else {return}
            descriptionViewController.modalPresentationStyle = .fullScreen
            navigationController.present(descriptionViewController, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true)
        }
    }
}

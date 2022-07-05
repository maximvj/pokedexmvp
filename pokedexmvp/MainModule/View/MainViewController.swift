//
//  ViewController.swift
//  mvppokemonproject
//
//  Created by Maxim on 06.06.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties

    var presenter: MainViewPresenterProtocol?
    private lazy var toolbar = UIToolbar()
    private lazy var mainCollectionView = MainCollectionView(view: view)
    private lazy var searchBar = UISearchBar()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setMainCollectionView()
        setSearchBar()
        setConstrains()
    }
    
    @objc func hideKeyboard () {
        searchBar.searchTextField.resignFirstResponder()
    }

    private func setMainCollectionView() {
        mainCollectionView.delegate   = self
        mainCollectionView.dataSource = self
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainCollectionView)
    }

    private func setSearchBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(hideKeyboard))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        searchBar.searchTextField.inputAccessoryView = toolbar
        searchBar.placeholder = "search pokemon"
        searchBar.backgroundColor = .white
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }

    private func setConstrains() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            mainCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        ])
    }
}

// MARK: - Extension UICollectionViewDelegate,UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.filteredPokemonsNames?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? MainCollectionViewCell {
            let name = presenter?.filteredPokemonsNames?[indexPath.row]
            if let image = presenter?.pokemonsDescription?[name ?? ""]?.image {
                cell.imageView.image = UIImage(data: image)
                cell.label.text = name?.capitalized
                return cell
            }
            return cell
        }
        return MainCollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let name = presenter?.filteredPokemonsNames?[indexPath.row] else { return }
        guard let description = presenter?.pokemonsDescription?[name] else {return }
        presenter?.tapOnPokemon(description: description)
    }
}

// MARK: - Extension UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterSearchResults(presenter: presenter, searchText: searchText)
    }
}

// MARK: - Extension MainViewProtocol

extension MainViewController: MainViewProtocol {

    func update(by index: Int, with imageData: Data?) {
        mainCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }

    func reloadData() {
        mainCollectionView.reloadData()
    }

    func failure() {

    }
}

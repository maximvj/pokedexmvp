//
//  MainCollectionView.swift
//  pokedexmvp
//
//  Created by Maxim on 03.07.2022.
//

import UIKit

class MainCollectionView: UICollectionView {

    init(view: UIView) {
        let layout = UICollectionViewFlowLayout()

        super.init(frame: .zero, collectionViewLayout: layout)

        layout.itemSize = CGSize(width: 350, height: 150)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = view.frame.width
        layout.scrollDirection = .vertical
        backgroundColor = .none

        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
        register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

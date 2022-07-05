//
//  MainCollectionViewCell.swift
//  pokemonProject
//
//  Created by Maxim on 22.05.2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

      // MARK: - Properties

    var label = CustomLabel()
    var image = UIImage()
    var imageView = UIImageView()

      // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setCell()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)
        contentView.addSubview(label)

          // MARK: - Constraints

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indent),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -2 * Constants.indent),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -2 * Constants.indent),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: contentView.bounds.width / 4)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

      // MARK: - Methods

    func setCell () {
        contentView.backgroundColor = .systemTeal
        contentView.layer.cornerRadius = 10
        layer.shadowRadius = 8.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }

}

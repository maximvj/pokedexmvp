//
//  DescriptionView.swift
//  mvppokemonproject
//
//  Created by Maxim on 28.06.2022.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: DescriptionPresenterProtocol?

    var name = CustomLabel()
    var weight = CustomLabel()
    var height = CustomLabel()
    var type = CustomLabel()

    var imageView = UIImageView()

    var stackView = UIStackView()

    var scrollView = UIScrollView()

    var backButton = CustomButton()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setDescription()
        name.setupTitle()
        backButton.delegate = self
        view.backgroundColor = .systemTeal
        view.addSubview(scrollView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 600)
        setStackView()
        setConstrains()
    }

    func setStackView() {
        stackView = UIStackView(arrangedSubviews: [name, imageView, weight, height, type, backButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setCustomSpacing(5, after: weight)
        stackView.setCustomSpacing(5, after: height)
        stackView.setCustomSpacing(20, after: type)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
    }

    func setConstrains() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

    }
}

// MARK: - Extension DescriptionViewProtocol

extension DescriptionViewController: DescriptionViewProtocol {
    func setDescription(description: Description) {

        name.text = description.name.capitalized
        weight.text = "Weight: \(description.weightKiloString) kg"
        height.text = "Height: \(description.heighMeterString) m"
        type.text = "Type: \(description.typeString)"

        if let unwrapImage = UIImage(data: description.image ) {
        self.imageView = UIImageView(image: unwrapImage)
        }
    }
}

// MARK: - Extension CustomButtonDelegate

extension DescriptionViewController: CustomButtonDelegate {
    func hasBeenTapped() {
        presenter?.tap()
    }

}

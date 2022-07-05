//
//  CustomButton.swift
//  pokedexmvp
//
//  Created by Maxim on 04.07.2022.
//

import UIKit

protocol CustomButtonDelegate: AnyObject {
    func hasBeenTapped()
}

class CustomButton: UIButton {

    weak var delegate: CustomButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemBlue
        setTitle("Back", for: .normal)
        titleLabel?.font = UIFont(name: "PingFangHK-Medium", size: 20.0)
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 10
        layer.shadowRadius = 8.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 5)
        self.frame.size.width = 200
        self.frame.size.height = 70
        addTarget(self, action: #selector(hasTapped), for: .touchUpInside)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func hasTapped() {
        delegate?.hasBeenTapped()
    }

}

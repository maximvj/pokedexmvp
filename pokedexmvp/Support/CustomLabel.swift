//
//  CustomLabel.swift
//  pokedexmvp
//
//  Created by Maxim on 03.07.2022.
//

import Foundation
import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setupTitle() {
        self.font = UIFont(name: "PingFangHK-Medium", size: 25.0)
        self.textAlignment = .center
    }

    private func setup() {
        self.font = UIFont(name: "PingFangHK-Medium", size: 20.0)
    }

}

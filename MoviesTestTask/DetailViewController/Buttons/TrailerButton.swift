//
//  TrailerButton.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import UIKit

final class TrailerButton: UIButton {
    override var isSelected: Bool {
        didSet { updateButtonAppearance() }
    }
    
    override var isHighlighted: Bool {
        didSet { updateButtonAppearance() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.height / 2
        backgroundColor = .white
    }
    
    private func updateButtonAppearance() {
        alpha = isSelected || isHighlighted ? 0.4 : 1
    }
}

//
//  CardView.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 20.08.2022.
//

import Foundation
import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSet()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSet()
    }
    func initialSet() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        cornerRadius = 10
    }
}

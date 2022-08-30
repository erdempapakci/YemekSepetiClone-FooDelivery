//
//  DishDisplayCollectionViewCell.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import UIKit

class DishDisplayCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setup(dish: Dish) {
        
        titleLabel.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        
        
    }
}

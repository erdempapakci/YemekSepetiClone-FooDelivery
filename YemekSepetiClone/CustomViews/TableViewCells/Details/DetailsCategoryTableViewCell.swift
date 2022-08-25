//
//  DetailsCategoryTableViewCell.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 25.08.2022.
//

import UIKit

class DetailsCategoryTableViewCell: UITableViewCell {

 
    
    
    
    func setup(dish: Dish) {

        dishListImageView.kf.setImage(with: dish.image?.asUrl)
        dishListTitleLabel.text = dish.name
        dishListDescriptionLabel.text = dish.description
        
        
    }
    func setup(order: Order) {
        dishListImageView.kf.setImage(with: order.dish?.image?.asUrl)
        dishListTitleLabel.text = order.dish?.name
        dishListDescriptionLabel.text = order.dish?.description
        
    }
}

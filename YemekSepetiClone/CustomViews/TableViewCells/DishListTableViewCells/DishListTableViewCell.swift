//
//  DishListTableViewCell.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    
    static let identifier = "DishListTableViewCell"

    @IBOutlet weak var dishListImageView: UIImageView!
    @IBOutlet weak var dishListTitleLabel: UILabel!
    @IBOutlet weak var dishListDescriptionLabel: UILabel!

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

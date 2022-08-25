//
//  CategoryCollectionViewCell.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 20.08.2022.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
   
    func setDish(category: DishCategory) {
        categoryTitleLabel.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asUrl)
     
    }

}



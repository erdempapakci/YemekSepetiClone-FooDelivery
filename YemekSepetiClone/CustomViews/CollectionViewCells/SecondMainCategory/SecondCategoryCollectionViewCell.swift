//
//  SecondCategoryCollectionViewCell.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 26.08.2022.
//

import UIKit

class SecondCategoryCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
   
    func setDish(category: DishCategory) {
        categoryTitleLabel.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asUrl)
     
    }

}

//
//  OfferCollectionViewCell.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 26.08.2022.
//

import UIKit
import Kingfisher
class OfferCollectionViewCell: BaseCollectionViewCell {
  
    @IBOutlet weak var imageView: UIImageView!
    
    func setDish(category: DishCategory) {
        
        imageView.kf.setImage(with: category.image?.asUrl)
        
    }
    
}


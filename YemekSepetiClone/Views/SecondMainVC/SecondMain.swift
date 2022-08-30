//
//  DetailViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 26.08.2022.
//

import UIKit
import ProgressHUD
class SecondMain: BaseViewController {
    
    @IBOutlet weak var topCategoryCollectionView: UICollectionView!
    @IBOutlet weak var OffersCollectionView: UICollectionView!
    
    var categories: [DishCategory] = []
    let images = [UIImage(named: "offer"),
                  UIImage(named: "offer"),
                  UIImage(named: "offer"),
                  UIImage(named: "offer")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FooDelivery"
        
        topCategoryCollectionView.delegate = self
        topCategoryCollectionView.dataSource = self
        OffersCollectionView.delegate = self
        OffersCollectionView.dataSource = self
        registerCells()
        
    }
    
    func registerCells() {
        topCategoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        OffersCollectionView.register(UINib(nibName: "OfferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OfferCollectionViewCell")
        
    }
    
}

extension SecondMain: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topCategoryCollectionView:
            return categories.count
            
        case OffersCollectionView:
            return images.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topCategoryCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.setDish(category: categories[indexPath.row])
            return cell
            
        case OffersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCollectionViewCell", for: indexPath) as! OfferCollectionViewCell
            cell.imageView.image = images[indexPath.row]
            return cell
            
        default: return UICollectionViewCell()
            
        }
    }
    
}

//
//  DetailViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 26.08.2022.
//

import UIKit
import ProgressHUD
class SecondMain: UIViewController {

    @IBOutlet weak var topCategoryCollectionView: UICollectionView!
    @IBOutlet weak var OffersCollectionView: UICollectionView!
    
    var categories: [DishCategory] = []
    var images: [Offer]?
   override func viewDidLoad() {
        super.viewDidLoad()
       topCategoryCollectionView.delegate = self
       topCategoryCollectionView.dataSource = self
       OffersCollectionView.delegate = self
       OffersCollectionView.dataSource = self
       fetch()
       
     let images = [Offer(image: UIImage(named: "offer1")!),
       Offer(image: UIImage(named: "offer2")!),
       Offer(image: UIImage(named: "offer3")!),
       Offer(image: UIImage(named: "offer4")!)
                   ]
       
    }
    func registerCells() {
        topCategoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        OffersCollectionView.register(UINib(nibName: "OfferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OfferCollectionViewCell")
        
    
    
    }
    
    func fetch() {
        
        
        Networkservice.shared.fetchAllCategories { [weak self ] (result) in
            switch result {
            case .success(let allDishes):
                
                DispatchQueue.main.async {
                     self?.categories = allDishes.categories ?? []
                    
                }
              
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    

    

}


extension SecondMain: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return categories.count
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topCategoryCollectionView:
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.setDish(category: categories[indexPath.row])
            return cell
        
        case OffersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCollectionViewCell", for: indexPath) as! OfferCollectionViewCell
           
            return cell
        
        
                   
        
            
           
        default: return UICollectionViewCell()
      
    }
}
}

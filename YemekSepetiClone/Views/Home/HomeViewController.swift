//
//  HomeViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 20.08.2022.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
   
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
   
    @IBOutlet weak var chefsBestCollection: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    var categories: [DishCategory] = []
    var populars: [Dish] = []
    
    var chef: [Dish] = []
    var isSlideMenuHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        title = "FooDelivery"
        
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
      
        registerCells()
        
        ProgressHUD.show()
        
        Networkservice.shared.fetchAllCategories { [weak self ] (result) in
            switch result {
            case .success(let allDishes):
                
                ProgressHUD.dismiss()
                self?.categories = allDishes.categories ?? []
                self?.populars = allDishes.populars ?? []
                self?.chef = allDishes.specials ?? []
                self?.foodCollectionView.reloadData()
                self?.popularCollectionView.reloadData()
                self?.chefsBestCollection.reloadData()
                
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    @IBAction func sideBarClicked(_ sender: Any) {
    
        
        
    }
    func registerCells() {
        foodCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        popularCollectionView.register(UINib(nibName: "DishDisplayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DishDisplayCollectionViewCell")
        chefsBestCollection.register(UINib(nibName: "DishLandscapeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DishLandscapeCollectionViewCell")
    
    
    
       
    
    }


}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case foodCollectionView:
            return categories.count
        
        case popularCollectionView:
            return populars.count
        
        case chefsBestCollection:
            return chef.count
        
        
        default: return 0
            
        }

    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case foodCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.setDish(category: categories[indexPath.row])
            return cell
        
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishDisplayCollectionViewCell", for: indexPath) as! DishDisplayCollectionViewCell
            cell.setup(dish: populars[indexPath.row])
            return cell
           
        case chefsBestCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishLandscapeCollectionViewCell", for: indexPath) as! DishLandscapeCollectionViewCell
            cell.setup(dish: chef[indexPath.row])
            
            return cell
        default: return UICollectionViewCell()
            
        }
        
        
        
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == foodCollectionView {
            let controller = ListDishesViewController.instantiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = DetailsViewController.instantiate()
            
            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : chef[indexPath.row]
            
            navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    
}

//
//  HomeViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 20.08.2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var foodCollectionView: UICollectionView!
   
    @IBOutlet weak var chefsBestCollection: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    var categories: [DishCategory] = [
        .init(id: "id", name: "Turkish Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id", name: "Korea Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id", name: "Greece Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id", name: "Poland Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id", name: "Russia Dish", image: "https://picsum.photos/100/200")
    ]
    var populars: [Dish] = [
        .init(id: "id", name: "Erdem Lok", description: "Gördüğü en iyisi", image: "https://picsum.photos/100/200", calories: 21),
        .init(id: "id2", name: "ad Lok", description: "sda", image: "https://picsum.photos/100/200", calories: 312),
        .init(id: "id3", name: "eren Lok", description: "baya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisi", image: "https://picsum.photos/100/200", calories: 321),
    
    ]
    
    var chef: [Dish] = [
        .init(id: "erd", name: "sad", description: "dsa", image: "https://picsum.photos/100/200", calories: 32),
        .init(id: "erd", name: "sad", description: "dsa", image: "https://picsum.photos/100/200", calories: 32),
        .init(id: "erd", name: "sad", description: "dsa", image: "https://picsum.photos/100/200", calories: 32),
        .init(id: "erd", name: "sad", description: "dsa", image: "https://picsum.photos/100/200", calories: 32)
    
    
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FooDelivery"
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        registerCells()
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
            
            navigationController?.present(controller, animated: true, completion: nil)
            
        }
    }
    
}

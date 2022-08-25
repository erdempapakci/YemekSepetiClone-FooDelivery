//
//  ListDishesViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import UIKit
import ProgressHUD
class ListDishesViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    var category : DishCategory!
    var dishes: [Dish] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCell()
        ProgressHUD.show()
        Networkservice.shared.fetchCategoryDishes(categoryId: category.id ?? "") { [weak self] (result) in
            switch result {
            case .success(let dishes):
                ProgressHUD.dismiss()
                self?.dishes = dishes
                self?.tableView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            
            }
        }
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "DishListTableViewCell", bundle: nil), forCellReuseIdentifier: "DishListTableViewCell")
        
        
    }
  

}
extension ListDishesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishListTableViewCell", for: indexPath) as! DishListTableViewCell
        
        cell.setup(dish: dishes[indexPath.row])
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailsViewController.instantiate()
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

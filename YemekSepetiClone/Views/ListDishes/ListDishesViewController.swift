//
//  ListDishesViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import UIKit

class ListDishesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var category : DishCategory!
    var dishes: [Dish] = [
        .init(id: "id", name: "Erdem Lok", description: "Gördüğü en iyisi", image: "https://picsum.photos/100/200", calories: 21),
        .init(id: "id2", name: "ad Lok", description: "sda", image: "https://picsum.photos/100/200", calories: 312),
        .init(id: "id3", name: "eren Lok", description: "baya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisibaya en iyisi", image: "https://picsum.photos/100/200", calories: 321),
    
    
    ]
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCell()
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

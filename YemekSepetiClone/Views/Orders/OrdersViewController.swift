//
//  OrdersViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import UIKit
import ProgressHUD

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var orderTableView: UITableView!
    
    var orders : [Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        title = "Siparişler"
        
        ProgressHUD.show()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        Networkservice.shared.fetchOrders { (result) in
            switch result {
            case .success(let orders):
                ProgressHUD.dismiss()
                self.orders = orders
                self.orderTableView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
                
            }
        }
        
    }
    
    func registerCells() {
        
        orderTableView.register(UINib(nibName: "DishListTableViewCell", bundle: nil), forCellReuseIdentifier: "DishListTableViewCell")
        
    }
    
}
extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishListTableViewCell", for: indexPath) as! DishListTableViewCell
        
        cell.setup(order: orders[indexPath.row])
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailsViewController.instantiate()
        controller.dish = orders[indexPath.row].dish
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

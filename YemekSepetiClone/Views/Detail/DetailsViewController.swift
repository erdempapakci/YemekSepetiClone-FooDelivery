//
//  DetailsViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailCaloriesLabel: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    
    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateView()

    }
    
    func populateView() {
        
        detailImage.kf.setImage(with: dish.image?.asUrl)
        detailTitle.text = dish.name
        detailCaloriesLabel.text = dish.formattedCalories
        detailDescriptionLabel.text = dish.description
        
        
    }

    @IBAction func siparisButtonClicked(_ sender: Any) {
    }
    

}

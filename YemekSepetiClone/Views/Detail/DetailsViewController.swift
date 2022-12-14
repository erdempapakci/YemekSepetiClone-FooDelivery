//
//  DetailsViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import UIKit
import ProgressHUD
import Firebase
class DetailsViewController: BaseViewController {
    
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
    
    @IBAction func siparisButtonClicked(_ sender: UIButton) {
        
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty, let email = emailTextField.text?.trimmingCharacters(in: .whitespaces),
              !email.isEmpty
        else {
            
            ProgressHUD.showError("Lütfen isim/email giriniz ")
            return
            
        }
        ProgressHUD.show("Placing Order...")
        Networkservice.shared.placeOrder(dishId: dish.id ?? "", name: name, email: email) {  (result) in
            switch result {
            case .success(_):
                
                if Auth.auth().currentUser == nil {
                    
                    print("error")
                    ProgressHUD.showError("Lütfen giriş yapınız")
                    
                } else {
                    
                    self.usersInfo()
                    ProgressHUD.showSuccess("Siparişiniz oluşturuldu.En yakın zamanda sipariş ulaşacaktır.")
                    
                }
                
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    func usersInfo() {
        
        let fireStoreDataBase = Firestore.firestore()
        let fireStoreReference : DocumentReference?
        
        let fireStorePost = [
            "Adress" : emailTextField.text!,
            "userName": nameTextField.text!,
            "Food": detailTitle.text!
            
        ] as [String : Any]
        
        fireStoreReference = fireStoreDataBase.collection("Users").addDocument(data: fireStorePost, completion: { (error) in
            if error != nil {
                
                print("error")
            } else {
                
                
            }
        })
        
    }
}

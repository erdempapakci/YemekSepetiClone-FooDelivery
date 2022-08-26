//
//  HomeViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 20.08.2022.
//

import UIKit
import ProgressHUD
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var signInButtonClicked: UIButton!
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var slideOutTableView: UITableView!
    @IBOutlet weak var authView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mahalleView: CardView!
    @IBOutlet weak var marketView: CardView!
    @IBOutlet weak var yemekView: CardView!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var signUpButtonClicked: UIButton!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var isBottomSheetShown = false
    let screen = UIScreen.main.bounds
    var menu = false
    var home = CGAffineTransform()
    var categories: [DishCategory] = []
    var populars: [Dish] = []
    var uIView = [CardView]()
    var chef: [Dish] = []
    var isSlideMenuHidden = true
    var options: [option]? = [    option(title: "Ayarlar", segue: "HomeSegue"),
                                  option(title: "Yardım Merkezi", segue: "SettingsSegue"),
                                  option(title: "Daha Fazla", segue: "MoreSegue"),
                                  option(title: "Kullanıcı Giriş", segue: "MoreSegue")
                                  
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()
        tap()
        registerCells()
        ProgressHUD.show()
        
        title = "FooDelivery"
        slideOutTableView.backgroundColor = .clear
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        slideOutTableView.delegate = self
        slideOutTableView.dataSource = self
        
        uIView = [mahalleView,marketView,yemekView]
        
        // SlideMenu
        home = containerView.transform
        
        
        topConstraint.constant = 770
        
    }
    
    // SlideMenu
    func showMenu() {
        
        let x = screen.width * 0.8
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7, animations: {
            self.containerView.transform = scaledAndTranslatedTransform
            
        })
    }
    
    @IBAction func showMenu(_ sender: Any) {
        
        if menu == false {
            UIView.animate(withDuration: 0.7, animations: {
                
                self.showMenu()
                self.menu = true
                self.view.bringSubviewToFront(self.slideOutTableView)
                
            })
        }else {
            UIView.animate(withDuration: 0.7, animations: {
                
                self.containerView.transform = self.home
                self.containerView.layer.cornerRadius = 0
                self.menu = false
                self.view.sendSubviewToBack(self.slideOutTableView)
                
            })
            
        }
        
    }
    
    func registerCells() {
        foodCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        popularCollectionView.register(UINib(nibName: "DishDisplayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DishDisplayCollectionViewCell")
        
    }
    
    func fetch() {
        
        Networkservice.shared.fetchAllCategories { [weak self ] (result) in
            switch result {
            case .success(let allDishes):
                
                ProgressHUD.dismiss()
                self?.categories = allDishes.categories ?? []
                self?.populars = allDishes.populars ?? []
                self?.chef = allDishes.specials ?? []
                self?.foodCollectionView.reloadData()
                self?.popularCollectionView.reloadData()
                
                
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: usernameText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "erro", messageInput: error?.localizedDescription ?? "rr")
                    
                } else {
                    self.makeAlert(titleInput: "", messageInput: "Başarıyla giriş yaptınız")
                    self.topConstraint.constant = 770
                    self.view.sendSubviewToBack(self.authView)
                    
                }
            }
            
        } else {
            
            makeAlert(titleInput: "Hata", messageInput: "Email / şifre eksik")
            
        }
        
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: usernameText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "erro", messageInput: error?.localizedDescription ?? "rr")
                    
                    
                } else {
                    self.makeAlert(titleInput: "Başarılı", messageInput: "Hesabınız oluşturuldu")
                    self.topConstraint.constant = 770
                    self.view.sendSubviewToBack(self.authView)
                    
                }
            }
            
        } else {
            
            makeAlert(titleInput: "Hata", messageInput: "Email / şifre eksik")
            
        }
        
    }
    func makeAlert(titleInput: String, messageInput: String ) {
        
        let controller = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        controller.addAction(ok)
        present(controller, animated: true)
        
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case foodCollectionView:
            return categories.count
            
        case popularCollectionView:
            return populars.count
          
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
    
    func tap() {
        mahalleView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedView))
        mahalleView.addGestureRecognizer(gesture)
        
    }
    
    @objc func tappedView() {
        
        performSegue(withIdentifier: "toGet", sender: nil)
        
    }
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SlideOutTableViewCell", for: indexPath) as! SlideOutTableViewCell
        cell.titleLabel.text = options?[indexPath.row].title
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.7, animations: {
                    
                    self.containerView.transform = self.home
                    self.containerView.layer.cornerRadius = 0
                    
                    self.menu = false
                    self.view.sendSubviewToBack(self.slideOutTableView)
                    
                    self.topConstraint.constant = 400
                    self.view.bringSubviewToFront(self.authView)
                })
        
    }
}

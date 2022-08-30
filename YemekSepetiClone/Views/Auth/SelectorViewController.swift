//
//  SelectorViewController.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 30.08.2022.
//

import UIKit
import FirebaseAuth
import Firebase

class SelectorViewController: BaseViewController, UISheetPresentationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        sheetPresentationController.preferredCornerRadius = 40
        sheetPresentationController.delegate = self
        sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium()
            
        ]
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: nameTextField.text!, password: passwordTextField.text!) { (authdata, error) in
            if error != nil {
                self.makeAlert(titleInput: "erro", messageInput: error?.localizedDescription ?? "rr")
                
                
            } else {
                self.makeAlert(titleInput: "Başarılı", messageInput: "Hesabınız oluşturuldu")
                self.dismissAuthSheet()
                
            }
        }
        
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        if nameTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: nameTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "rr")
                    
                } else {
                    self.makeAlert(titleInput: "", messageInput: "Başarıyla giriş yaptınız")
                    self.dismissAuthSheet()
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
    func dismissAuthSheet() {
        
        sheetPresentationController.dismissalTransitionWillBegin()
        
    }
    
}



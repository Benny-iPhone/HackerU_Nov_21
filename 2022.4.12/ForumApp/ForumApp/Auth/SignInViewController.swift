//
//  SignInViewController.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import UIKit
import FirebaseAuth
import PKHUD

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInAction(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        HUD.show(.progress)
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error)
                HUD.flash(.error, delay: 1.5)
                return
            }
            
            HUD.flash(.success, delay: 1.5)
            FlowManager.shared.determineFlow()
        }
        
    }

    @IBAction func forgotPasswordAction(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else { return }
        
        HUD.show(.progress)
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error)
                HUD.flash(.error, delay: 1.5)
                return
            }
            
            HUD.flash(.success, delay: 1.5)
        }
        
    }
    
}

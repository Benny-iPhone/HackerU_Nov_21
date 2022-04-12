//
//  SignUpViewController.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import UIKit
import FirebaseAuth
import PKHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        guard let nickname = nicknameTextField.text, !nickname.isEmpty else { return }
        
        HUD.show(.progress)
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error)
                HUD.flash(.error, delay: 1.5)
                return
            }
            
            //update name
            guard let user = result?.user else { return }
            let request = user.createProfileChangeRequest()
            request.displayName = nickname
            request.commitChanges { _ in
                HUD.flash(.success, delay: 1.5)
                FlowManager.shared.determineFlow()
            }
        }
    }
    

}

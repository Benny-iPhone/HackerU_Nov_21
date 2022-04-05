//
//  MenuViewController.swift
//  OneTimePassword
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInAction(_ sender: Any) {
        //create instance of OTPViewController using storyboard-id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        //set its viewModel instance to sign-in
        vc.viewModel = OTPSignInViewModel()
        //show it
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func adminAction(_ sender: Any) {
        //create instance of OTPViewController using storyboard-id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        //set its viewModel instance to admin flow
        vc.viewModel = OTPAdminOperationViewModel()
        //show it
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

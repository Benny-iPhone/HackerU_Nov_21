//
//  ViewController.swift
//  GenderAPI
//
//  Created by Benny Davidovitz on 08/03/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func checkGenderAction(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            return
        }
        
        //disable button to avoid duplicate request
        sender.isEnabled = false
        
        //weak to avoid reference cycle like:
        //ViewController -> Networking -> Clouse -> ViewController
        Networking.shared.checkGenderAlamofire(by: name) { [weak self] result in
            guard let self = self else { return }
            //response returned, re-enable button
            sender.isEnabled = true
            //handle result
            switch result {
            case .failure(let error):
                print(error)
            case .success(let answer):
                self.resultLabel.text = answer.gender + " - \(answer.accuracy)%"
            }
        }
        
        
        
    }
    
}


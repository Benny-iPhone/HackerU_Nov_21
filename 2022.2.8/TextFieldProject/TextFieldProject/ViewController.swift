//
//  ViewController.swift
//  TextFieldProject
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackviewTop: NSLayoutConstraint!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: ToolbarTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var birthdateTextField: DateTextField!
    @IBOutlet weak var genderTextField: GenderTextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateSubmitButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    deinit {
        //remove registration when object release
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardShow(_ note: Notification) {
        //https://stackoverflow.com/questions/31774006/how-to-get-height-of-keyboard
        let keyboardHeight = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        
        //Benny TODO: take care of scroll view
        
    }
    
    @objc func handleKeyboardHide(_ note: Notification) {
        //Benny TODO: take care of scroll view
    }
    
    private func updateSubmitButton() {
        //first name must be valid
        guard let firstName = firstNameTextField.text, firstName.isContainsNonWhiteSpaces else {
            submitButton.isEnabled = false
            return
        }
        
        //first name must be valid
        guard let lastName = lastNameTextField.text, lastName.isContainsNonWhiteSpaces else {
            submitButton.isEnabled = false
            return
        }
        
        //email must be valid
        guard let email = emailTextField.text, email.isValidEmail else {
            submitButton.isEnabled = false
            return
        }
        
        //phone must be valid
        guard let phoneNumber = phoneNumberTextField.text, phoneNumber.isValidPhoneNumber else {
            submitButton.isEnabled = false
            return
        }
        
        submitButton.isEnabled = true
    }
    
    @IBAction func textFieldChangedAction(_ sender: Any) {
        updateSubmitButton()
    }
    
    
    @IBAction func tapAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    //return key pressed
    @IBAction func nextPressedAction(_ sender: UITextField) {
        if let nextTextField = self.view.viewWithTag(sender.tag + 1) {
            //next field to focus is available
            nextTextField.becomeFirstResponder()
        } else {
            //last input, close keyboard
            sender.resignFirstResponder()
        }
    }


}


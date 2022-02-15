//
//  ViewController.swift
//  TextFieldProject
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    struct FormData: Codable {
        let firstName: String
        let lastName: String
    }

    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    
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
        
        loadSavedFormData()
        // Do any additional setup after loading the view.
        updateSubmitButton()
        
        //and now we have to conforms to protocol UITextFieldDelegate
        firstNameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppTerminated(_:)), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    private func loadSavedFormData() {
        guard let data = UserDefaults.standard.data(forKey: "formData") else {
            //we do not have any saved data
            return
        }
        
        //parse data to FormData
        guard let formData = try? JSONDecoder().decode(FormData.self, from: data) else {
            return
        }
        
        firstNameTextField.text = formData.firstName
        lastNameTextField.text = formData.lastName
    }
    
    deinit {
        //remove registration when object release
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleAppTerminated(_ note: Notification) {
        let formData = FormData(firstName: firstNameTextField.text ?? "",
                                lastName: lastNameTextField.text ?? "")
        if let data = try? JSONEncoder().encode(formData) {
            UserDefaults.standard.set(data, forKey: "formData")
            UserDefaults.standard.synchronize()
        }
        
        print("app is about to crash")
    }
    
    @objc func handleKeyboardShow(_ note: Notification) {
        //https://stackoverflow.com/questions/31774006/how-to-get-height-of-keyboard
        let keyboardHeight = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        let diff = max(keyboardHeight - self.view.safeAreaInsets.bottom,0)
        scrollViewBottom.constant = diff
    }
    
    @objc func handleKeyboardHide(_ note: Notification) {
        scrollViewBottom.constant = 0
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


extension ViewController: UITextFieldDelegate {
    
    //https://www.hackingwithswift.com/example-code/uikit/how-to-limit-the-number-of-characters-in-a-uitextfield-or-uitextview
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 5 characters, and without emojies
        return updatedText.count <= 5 && updatedText.containsEmoji == false
    }
    
}

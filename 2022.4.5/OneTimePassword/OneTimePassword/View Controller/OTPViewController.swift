//
//  OTPViewController.swift
//  OneTimePassword
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import UIKit



class OTPViewController: UIViewController {
    
    var viewModel: OTPVCViewModel!

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateUI()
        refreshUI()
    }
    
    //fill ui with content
    private func populateUI() {
        navigationItem.title = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        phoneTextField.placeholder = viewModel.phonePlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
    }
    
    //update ui
    private func refreshUI() {
        actionButton.setTitle(viewModel.buttonTitle, for: .normal)
        actionButton.isEnabled = viewModel.canClickButton
        
        phoneTextField.isEnabled = viewModel.shouldEnablePhoneInput
        passwordTextField.isHidden = viewModel.shouldHideCodeInput
    }
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        viewModel.performAction { [weak self] in
            guard let self = self else { return }
            self.refreshUI()
        }
    }
    
    @IBAction func textFieldChangedAction(_ sender: UITextField) {
        switch sender {
        case phoneTextField:
            viewModel.phone = sender.text ?? ""
        case passwordTextField:
            viewModel.otpCode = sender.text ?? ""
        default:
            return
        }
        
        //update ui,cause view model content changed
        self.refreshUI()
    }
    

}

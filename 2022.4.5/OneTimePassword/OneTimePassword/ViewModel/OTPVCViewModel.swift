//
//  OTPVCViewModel.swift
//  OneTimePassword
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import Foundation

enum OTPFlow {
    case phoneInput
    case otpCodeInput
}

protocol OTPVCViewModel {
    //OTPVCViewModel requires to provide the next getters
    var title: String { get }
    var subTitle: String { get }
    var buttonTitle: String { get }
    var phonePlaceholder: String { get }
    var passwordPlaceholder: String { get }
    
    var phone: String { get set }
    var otpCode: String { get set }
    var flow: OTPFlow { get }
    
    func performAction(with callback: @escaping ()->Void)
    
}

//default implementation
extension OTPVCViewModel {
    
    var buttonTitle: String {
        "click me"
    }
    
    var phonePlaceholder: String {
        "your phone number"
    }
    
    var passwordPlaceholder: String {
        "password received via sms"
    }
    
    var shouldEnablePhoneInput: Bool {
        return flow == .phoneInput
    }
    
    var shouldHideCodeInput: Bool {
        return flow == .phoneInput
    }
    
    var canClickButton: Bool {
        switch flow {
        case .phoneInput:
            return phone.count >= 10
        case .otpCodeInput:
            return otpCode.count >= 4
        }
    }
    
}

class OTPSignInViewModel: OTPVCViewModel {
    
    var flow: OTPFlow = .phoneInput
    var phone: String = ""
    var otpCode: String = ""
    private var sessionId: String = ""
    
    var title: String { "Complete Sign In" }
    var subTitle: String {
        "In order to complete sign in process\na two factor authentication is required"
    }
    
    func performAction(with callback: @escaping () -> Void) {
        switch flow {
        case .phoneInput:
            MockNetworking.shared.sendCodeTo(phone: self.phone) { result in
                switch result {
                case .success(let sessionId):
                    self.sessionId = sessionId
                    self.flow = .otpCodeInput
                case .failure(let error):
                    print(error)
                }
            }
        case .otpCodeInput:
            MockNetworking.shared.validate(code: self.otpCode, sessionId: self.sessionId) { result in
                switch result {
                case .success(let sessionId):
                    MockNetworking.shared.finishSignIn(sessionId: self.sessionId) { result in
                        
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
}

class OTPAdminOperationViewModel: OTPVCViewModel {
    var flow: OTPFlow = .phoneInput
    var phone: String = ""
    var otpCode: String = ""
    
    var title: String { "Account Security" }
    var subTitle: String {
        "In order to complete operation\na two factor authentication is required"
    }
    
    func performAction(with callback: @escaping () -> Void) {
    }
}

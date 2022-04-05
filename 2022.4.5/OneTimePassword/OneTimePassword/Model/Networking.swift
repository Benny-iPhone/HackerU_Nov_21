//
//  Networking.swift
//  OneTimePassword
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import Foundation

class MockNetworking {
    
    static let shared = MockNetworking()
    
    //a function to send the code to server, return session-id (String) on succefull operation
    func sendCodeTo(phone: String, callback: @escaping (Result<String,Error>)->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let sessionId = UUID().uuidString
            callback(.success(sessionId))
        }
    }
    
    //validate code using retreived session id
    func validate(code: String, sessionId: String, callback: @escaping (Result<Bool,Error>)->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(.success(true))
        }
    }
    
    func finishSignIn(sessionId: String, callback: @escaping (Result<Bool,Error>)->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(.success(true))
        }
    }
    
    func permitAdminOperation(sessionId: String, callback: @escaping (Result<Bool,Error>)->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(.success(true))
        }
    }
}

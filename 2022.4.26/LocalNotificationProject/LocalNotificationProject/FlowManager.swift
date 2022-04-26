//
//  FlowManager.swift
//  LocalNotificationProject
//
//  Created by Benny Davidovitz on 26/04/2022.
//

import UIKit

class FlowManager {
    
    static let shared = FlowManager()
    
    weak var window: UIWindow?
    
    private func getNavigationController() -> UINavigationController? {
        return self.window?.rootViewController as? UINavigationController
    }
    
    func showUserProfile(with userInfo: [AnyHashable:Any]) {
        let profieVC = UserProfileViewController.createVC()
        profieVC.userInfo = userInfo
        
        self.getNavigationController()?.pushViewController(profieVC, animated: true)
    }
    
}

//
//  FlowManager.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import UIKit
import FirebaseAuth

class FlowManager {
    
    static let shared = FlowManager()
    
    weak var window: UIWindow?
    
    func determineFlow() {
        if Auth.auth().currentUser == nil {
            //auth required
            showAuthFlow()
        } else {
            //auth completed
            showMainFlow()
        }
    }
    
    private func showMainFlow() {
        showFlow(storyboardName: "Main")
    }
    
    private func showAuthFlow() {
        showFlow(storyboardName: "Auth")
    }
    
    private func showFlow(storyboardName: String) {
        //this method might be called from background thread, therefore, we need to validate that if this is the case, we re-call this method on main thread
        guard Thread.isMainThread else {
            //go to main thread
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showFlow(storyboardName: storyboardName)
            }
            return
        }
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        //the previous rootViewController (empty flow, x flow) looses its reference and therefore released.
        window?.rootViewController = storyboard.instantiateInitialViewController()
        /*
         -- a side note --
         why our UITextField (in sign-up view controller) is alive? what is the reference chain
         UITextField has reference from its superview (UIStackView)
         which has a reference from its superview (the big white view, an UIView)
         Thats view is a property of its UIViewController (self.view)
         SignUpViewController is part of its UINavigationController's viewController array.
         And the UIWindow retain a reference to the navigation-controller by its 'rootViewController' propery.
         The SceneDelegate keep a reference to the Window (see SceneDelegate.swift line 12)
         The AppDelegate keeps a reference to all its scenes.
         And the appDelegate is a delegate of UIApplication, so this one have a reference too.
         UIApplication is a singleton.
         
         UIApplication -> AppDelegate -> SceneDelegate -> UIWindow -> UINavigationController -> SignUpViewController -> UIView -> UIStackView -> UITextField
         */
    }
    
}

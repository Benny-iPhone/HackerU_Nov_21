//
//  ViewController.swift
//  NotifyScreenshot
//
//  Created by Benny Davidovitz on 15/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerNotification()
    }
    
    deinit {
        //un-register all notifications
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerNotification() {
        //upon userDidTakeScreenshotNotification call handleScreenshot function on self (ViewController)
        NotificationCenter.default.addObserver(self, selector: #selector(handleScreenshot(note:)), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    @objc func handleScreenshot(note: Notification) {
        //save to UserDefaults (memory & disk)
        UserDefaults.standard.set(true, forKey: "didTakeScreenshot")
        UserDefaults.standard.synchronize()
        
        let alert = UIAlertController(title: "yo!", message: "you took a screenshot", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Bye Bye", style: .default, handler: { _ in
            self.closeApp()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func closeApp() {
        UIView.animate(withDuration: 1) {
            //fadeout ui
            self.view.window?.alpha = 0
        } completion: { _ in
            //kill app
            //https://stackoverflow.com/questions/50799108/how-to-terminate-an-app-programmatically-in-ios-12
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        }

    }
    
    


}


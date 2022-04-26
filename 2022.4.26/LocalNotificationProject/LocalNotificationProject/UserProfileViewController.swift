//
//  UserProfileViewController.swift
//  LocalNotificationProject
//
//  Created by Benny Davidovitz on 26/04/2022.
//

import UIKit

class UserProfileViewController: UIViewController {

    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // [:] - an empty dictionary
    var userInfo: [AnyHashable:Any] = [:]
    
    class func createVC() -> UserProfileViewController {
        return UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let id = userInfo["user_id"] as? Int {
            idLabel.text = "user_id: \(id)"
        }
        
        if let name = userInfo["user_name"] as? String {
            nameLabel.text = "user_name: " + name
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

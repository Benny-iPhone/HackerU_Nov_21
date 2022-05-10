//
//  ViewController.swift
//  MemoryFun
//
//  Created by Benny Davidovitz on 10/05/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var myStudent: Student?
    var secondVC: SecondViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .orange
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //st1 will be destoyed when viewDidLoad finish, and st1 Student's memory will be free
            let st1 = Student(name: "David")
            print(st1.name)
            
            //however, as long as ViewController is alive, myStudent's memory is still allocated
            self.myStudent = Student(name: "Shlomo")
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { _ in
            print("handle didBecomeActiveNotification")
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? SecondViewController {
            self.secondVC = nextVC
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
    }
    
}


//
//  ViewController.swift
//  RetainCycleWithTimer
//
//  Created by Benny Davidovitz on 10/05/2022.
//

import UIKit

class ViewController: UIViewController {

    var isRed: Bool = false
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] timerRef in
            print("timer action")
            guard let self = self else {
                timerRef.invalidate()
                print("timer invalidated")
                return
            }
            if self.isRed {
                self.view.backgroundColor = .white
            } else {
                self.view.backgroundColor = .red
            }
            
            self.isRed.toggle()
        }
    }

    @IBAction func buttonAction(_ sender: Any) {
        myFunc()
    }
    
    private func myFunc() {
        print(#function)
    }
}


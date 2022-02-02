//
//  ViewController.swift
//  HelloButton
//
//  Created by Benny Davidovitz on 01/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button2.setAttributedTitle(NSAttributedString(string: "click me 2", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
        setupButton()
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        button.isEnabled = sender.isOn
    }
    
    private func setupButton() {
        //button.backgroundColor = .black.withAlphaComponent(0.6)
        button.setTitle("Click Me", for: .normal)
        button.setTitle("Clicking", for: .highlighted)
        button.setTitleColor(.orange, for: .highlighted)
        
        button.setTitle("Do touch me", for: .disabled)
        
        button.setTitle("Selected", for: .selected)
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        //sender.isUserInteractionEnabled = false
        sender.isSelected = !sender.isSelected
    }
    
}


//
//  ViewController.swift
//  ReadWriteDisk
//
//  Created by Benny Davidovitz on 04/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    let storage = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func writeAction(_ sender: Any) {
        guard let text = textField.text else {
            return
        }
        guard let data = text.data(using: .utf8) else {
            return
        }
        storage.write(data: data, filename: "test.txt")
    }
    
    @IBAction func readAction(_ sender: Any) {
        guard let data = storage.read(filename: "test.txt") else {
            return
        }
        
        let text = String(data: data, encoding: .utf8)
        label.text = text
    }
    
}


//
//  ViewController.swift
//  ColorPickerAndDelegate
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pickAColorAction(_ sender: Any) {
        let pickerVC = ColorPickerViewController.createVC()
        pickerVC.delegate = self
        self.present(pickerVC, animated: true, completion: nil)
    }
    
}

extension ViewController: ColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ contrller: ColorPickerViewController, didSelectColor color: UIColor) {
        //use selected color
        self.view.backgroundColor = color
        //close color picker
        contrller.dismiss(animated: true, completion: nil)
    }
    
    
}


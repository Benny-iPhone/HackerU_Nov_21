//
//  ViewController.swift
//  Homework_25_1_2022
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

//https://stackoverflow.com/a/58158413/6133419
extension UIColor {
    var hexString: String {
        cgColor.components![0..<3]
            .map { String(format: "%02lX", Int($0 * 255)) }
            .reduce("#", +)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brownView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var hexLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //update the ui upon loading
        sliderAction()
        
        //load the image to the image view as template
        imageView.image = UIImage(named: "icons8-car")?.withRenderingMode(.alwaysTemplate)
    }

    @IBAction func switchAction(_ sender: UISwitch) {
        //isOn is an attribute of UISwitch, tell us if it on or off
        //switchAction will be called when switch value changed
        //isHidden - if true => View is not visible
        //! not - true become false, false become true
        brownView.isHidden = !sender.isOn
    }
    
    //function is called when slider value changed
    @IBAction func sliderAction() {
        //.value - is a Float with current value, lays between the slider maximum value in minimum value (0...1 in our use case)
        let redVal = CGFloat(redSlider.value)
        let blueVal = CGFloat(blueSlider.value)
        let greenVal = CGFloat(greenSlider.value)
        
        //alpha - opacity of the color - 1: opaque 0: clear
        let color = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: 1)
        self.view.backgroundColor = color
        //also modify image tint
        imageView.tintColor = color
        
        //display the color as hex value
        hexLabel.text = color.hexString
    }
    
    
}


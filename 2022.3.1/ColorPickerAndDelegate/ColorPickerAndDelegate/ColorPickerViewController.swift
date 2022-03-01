//
//  ColorPickerViewController.swift
//  ColorPickerAndDelegate
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import UIKit
import Colorful

//AnyObject - only classes can adopt this protocol
//ColorPickerViewControllerDelegate - define the communicate interface between ColorPickerViewController and its presenter

protocol ColorPickerViewControllerDelegate: AnyObject {
    //in this method, the ColorPickerViewController send itself, and the selected color
    //its common to start the function name with the name of the broadcasting class
    //P.S. function name is: colorPickerViewController:didSelectColor:
    func colorPickerViewController(_ contrller: ColorPickerViewController, didSelectColor color: UIColor)
    
}

class ColorPickerViewController: UIViewController {
    
    //a reference to that instance that conforms to ColorPickerViewControllerDelegate protocol
    //we might address that instance and send it messages
    //weak - in order to avoid retain cycle, we refer the delegate as weak
    weak var delegate: ColorPickerViewControllerDelegate?
    weak var colorPicker: ColorPicker!

    class func createVC() -> ColorPickerViewController {
        //UIStoryboard(name: "Main", bundle: .main) - a reference to a storyboard (file name: Main, in our main folder - bundle)
        //instantiateViewController - create instance of view controller according to provided identifier
        return UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ColorPickerViewController") as! ColorPickerViewController
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.modalTransitionStyle = .flipHorizontal

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildColorfulUI()
    }
    
    private func buildColorfulUI() {
        let colorPicker = ColorPicker()
        colorPicker.set(color: .red, colorSpace: .extendedSRGB)
        
        //progromatic layout
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorPicker)
        
        [
            colorPicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            colorPicker.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorPicker.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            colorPicker.heightAnchor.constraint(equalToConstant: 200)
        ].forEach { $0.isActive = true }
        
//        layouts.forEach{ item in
//            item.isActive = true
//        }
//        for item in layouts {
//            item.isActive = true
//        }
        
        //IBOutlet alike
        self.colorPicker = colorPicker
    }
    
    @IBAction func doneAction(_ sender: Any) {
//        let color: UIColor
//        switch colorsSegmentedControl.selectedSegmentIndex {
//        case 0:
//            color = .black
//            print("black")
//        case 1:
//            color = .white
//            print("white")
//        case 2:
//            color = .blue
//            print("blue")
//        case 3:
//            color = .orange
//            print("orange")
//        default:
//            return
//        }
        
        //notify delegate about our selection
        delegate?.colorPickerViewController(self, didSelectColor: colorPicker.color)
        
    }
    

}

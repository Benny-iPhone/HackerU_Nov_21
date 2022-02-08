//
//  GenderTextField.swift
//  TextFieldProject
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import UIKit

//CaseIterable add ability to iterate all cases
enum Gender: Int, CaseIterable {
    case noGender
    case male
    case female
}

class GenderTextField: ToolbarTextField, UIPickerViewDataSource ,UIPickerViewDelegate {

    //provide an easy access to selected gender
    var gender: Gender? {
        guard let pickerView = self.inputView as? UIPickerView else {
            return nil
        }
        let row = pickerView.selectedRow(inComponent: 0)
        return Gender(rawValue: row)
    }
    
    //from storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .systemBackground
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.inputView = pickerView
    }
    
    //MARK: - UIPickerView Support
    //how many wheels - 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //how many rows for a specific wheel
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
    
    //text for [row, wheel]
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let gender = Gender(rawValue: row) else {
            return nil
        }
        
        switch gender {
        case .noGender:
            return "Prefer not to say"
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
    
    //update on selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let gender = Gender(rawValue: row) else {
            return
        }
        
        switch gender {
        case .noGender:
            self.text = "Prefer not to say"
        case .male:
            self.text = "Male"
        case .female:
            self.text = "Female"
        }
    }
    
}

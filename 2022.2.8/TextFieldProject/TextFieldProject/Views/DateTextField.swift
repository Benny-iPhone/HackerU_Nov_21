//
//  DateTextField.swift
//  TextFieldProject
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import UIKit

class DateTextField: ToolbarTextField {
    
    //provide an easy access to selected date
    var date: Date? {
        (self.inputView as? UIDatePicker)?.date
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
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .systemBackground
        
        //hook action to date picker, like IBAction
        datePicker.addTarget(self, action: #selector(datePickerAction(_:)), for: .valueChanged)
        
        self.inputView = datePicker
    }
    
    @objc func datePickerAction(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        self.text = formatter.string(from: sender.date)
    }

}

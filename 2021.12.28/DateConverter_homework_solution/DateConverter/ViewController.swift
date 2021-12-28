//
//  ViewController.swift
//  DateConverter
//
//  Created by Benny Davidovitz on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {

    //TODO: setup an enum ConvertMode: Int { case gregToHeb, hebToGreg }
    enum ConvertMode: Int {
        case gregToHeb //0
        case hebToGreg //1
    }
    
    //reference to the Greg to heb / heb to greg element
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //reference to the date picker
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //invoke the update method to set the label with proper initial value
        self.dateChanged(datePicker)
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        //sender.selectedSegmentIndex
        guard let mode = ConvertMode(rawValue: segmentedControl.selectedSegmentIndex) else {
            //If value (for example 2) is not present in the enum - this is unexpected error
            //This is why mode is optional
            print("unsupported index \(segmentedControl.selectedSegmentIndex)")
            return
        }
        
        //TODO: update date picker calenda and locale
        //datePicker.calendar = Calendar(identifier: .coptic)
        switch mode {
        case .gregToHeb:
            datePicker.calendar = Calendar(identifier: .gregorian)
            datePicker.locale = Locale(identifier: "en")
        case .hebToGreg:
            datePicker.calendar = Calendar(identifier: .hebrew)
            datePicker.locale = Locale(identifier: "he")
        }
        
        //TODO: update label (dateChanged)
        self.dateChanged(datePicker)
    }
    
    
    
    //this called when date changed (change ended)
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        //textfield has text, datepicker has date
        let date = sender.date

        //format the date into string
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        guard let mode = ConvertMode(rawValue: segmentedControl.selectedSegmentIndex) else {
            //If value (for example 2) is not present in the enum - this is unexpected error
            //This is why mode is optional
            print("unsupported index \(segmentedControl.selectedSegmentIndex)")
            return
        }
        
        switch mode {
        case .gregToHeb:
            formatter.locale = Locale(identifier: "he")
            formatter.calendar = Calendar(identifier: .hebrew)
        case .hebToGreg:
            formatter.locale = Locale(identifier: "en")
            formatter.calendar = Calendar(identifier: .gregorian)
        }
        
        let dateString = formatter.string(from: date) //"\(date)"
        //display dateString in UI
        resultLabel.text = dateString
    }
    


}


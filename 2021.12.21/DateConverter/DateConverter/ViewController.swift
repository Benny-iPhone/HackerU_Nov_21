//
//  ViewController.swift
//  DateConverter
//
//  Created by Benny Davidovitz on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {

    //TODO: setup an enum ConvertMode: Int { case gregToHeb, hebToGreg }
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
        
        //TODO: update date picker calenda and locale
        //datePicker.calendar = Calendar(identifier: .coptic)
        
        //TODO: update label (dateChanged)
    }
    
    
    
    //this called when date changed (change ended)
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        //textfield has text, datepicker has date
        let date = sender.date

        //format the date into string
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        if segmentedControl.selectedSegmentIndex == 0 {
            formatter.locale = Locale(identifier: "he")
            formatter.calendar = Calendar(identifier: .hebrew)
        } else {
            formatter.locale = Locale(identifier: "en")
            formatter.calendar = Calendar(identifier: .gregorian)
        }
        
        let dateString = formatter.string(from: date) //"\(date)"
        //display dateString in UI
        resultLabel.text = dateString
    }
    


}


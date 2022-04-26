//
//  ViewController.swift
//  LocalNotificationProject
//
//  Created by Benny Davidovitz on 26/04/2022.
//

import UIKit


class ViewController: UIViewController {
    
    var sounds = [
        "arcade-retro-game-over",
        "fast-small-sweep-transition",
        "retro-game-notification"
    ]
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    @IBOutlet weak var badgeStepper: UIStepper!
    @IBOutlet weak var badgeLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationManager.shared.requestPermission()
        
        //setup ui
        titleTextField.text = "Friend Request"
        bodyTextField.text = "Steve Ballmer sent you a friend request"
        
        //picker view
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    
    

    @IBAction func badgeStepperAction(_ sender: UIStepper) {
        badgeLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func scheduleAction(_ sender: UIButton) {
        
        let row = pickerView.selectedRow(inComponent: 0)
        let soundName = sounds[row]
        
        NotificationManager.shared.requestNotification(title: titleTextField.text ?? "",
                                                       body: bodyTextField.text ?? "",
                                                       soundName: soundName,
                                                       badge: Int(badgeStepper.value),
                                                       timeInterval: 10)
        
    }
    
    
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sounds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sounds[row]
    }
    
}

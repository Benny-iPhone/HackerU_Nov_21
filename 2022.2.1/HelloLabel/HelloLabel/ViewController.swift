//
//  ViewController.swift
//  HelloLabel
//
//  Created by Benny Davidovitz on 01/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        firstLabel.text = (0...100)
            .compactMap{ "\($0)"}
            .joined(separator: ",")
        */
        //useAttributedTest()
        
        //firstLabel.font = UIFont(name: "ZenKurenaido-Regular", size: 20)
        firstLabel.font = .zenKurenaido()
        
        useAttributeTextPartial()
        buildLabelFromCode()
        buildLabelFromCodeWithLayout()
    }
    
    //attribute to parts of the text
    private func useAttributeTextPartial() {
        let text = "Hello Hackeru Students"
        //in order to find location of specific word, we need NSString api.
        //NSString is a class for String is Objective-C
        let word = "Hackeru"
        let rangeOfHackeru: NSRange = (text as NSString).range(of: word)
        if rangeOfHackeru.length == 0 {
            //not found
            return
        }
        
        //NSMutableAttributedString is subclass of NSAttributedString
        //just like NSMutableArray is subclass of NSArray
        let attText = NSMutableAttributedString(string: text)
        attText.addAttributes([
            .font: UIFont.boldSystemFont(ofSize: 40),
            .foregroundColor: UIColor.purple,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: UIColor.green
        ], range: rangeOfHackeru)
        
        firstLabel.attributedText = attText
        
    }
    
    private func useAttributedTest() {
        let text = "Hello Label"
        let attText = NSAttributedString(string: text, attributes: [
            .underlineStyle : NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.red,
            .backgroundColor: UIColor.yellow
        ])
        firstLabel.attributedText = attText
    }
    
    private func buildLabelFromCodeWithLayout() {
        //.zero = CGRect with x,y, width, height all 0
        let label = AppLabel(frame: .zero)
        //this line is mandatory, if you won't use it, UIKit will create layout rules of its own
        label.translatesAutoresizingMaskIntoConstraints = false
        //\n - line break
        label.text = "Hi There\nHi3"
        label.backgroundColor = .systemRed.withAlphaComponent(0.2)
        self.view.addSubview(label)

        //adding layout constraints can be done only AFTER view added
        
        //16 left
        //label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        //label leading x value = view leading x val (0) + 16 = 16
        label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        //16 bottom
        //label bottom y value = view bottom y value (700) - 16 = 684
        label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        //right
        //label trailing x value = view trailing x val (320) - 16 = 304
        label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
    }
    
    private func buildLabelFromCode() {
        let label = AppLabel(frame: CGRect(x: 40, y: 480, width: 140, height: 120))
        //\n - line break
        label.text = "Hi There\nHi2"
        self.view.addSubview(label)
    }


}


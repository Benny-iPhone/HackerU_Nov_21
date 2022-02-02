//
//  ViewController.swift
//  RotatesForever
//
//  Created by Benny Davidovitz on 01/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var timer: Timer?
    
    //timer action will be invoked every 0.005 second
    var timerTick: TimeInterval { 0.005 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //in order for the tap to work, we need to enable touches
        imageView.isUserInteractionEnabled = true
    }

    @IBAction func tapAction(_ sender: Any) {
        if let timer = self.timer {
            //stop
            timer.invalidate()
            self.timer = nil
        } else {
            //start
            self.timer = Timer.scheduledTimer(timeInterval: self.timerTick, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    //@objc - a function that completable with objective-c function
    @objc func timerAction() {
        let transform = imageView.transform
        //pi radians = 180 degress
        //in order to rotate by 1 degree
        //1 / 180 * 3.14 = 0.0174444..444
        //therefore lets go with 0.01
        //imageView.transform = transform.rotated(by: 0.0174444)
        imageView.transform = transform.rotated(by: CGFloat.pi / 180)
    }
    
}


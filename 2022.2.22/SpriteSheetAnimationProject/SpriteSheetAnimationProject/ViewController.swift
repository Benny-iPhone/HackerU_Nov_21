//
//  ViewController.swift
//  SpriteSheetAnimationProject
//
//  Created by Benny Davidovitz on 22/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImageView()
    }
    
    private func loadImageView() {
        let images = SpriteSheetMaker.cropSpriteSheet(image: UIImage(named: "spritesheet")!, columns: 5, rows: 2)
        imageView.animationImages = images
        imageView.image = images.first
        imageView.isUserInteractionEnabled = true
        imageView.animationDuration = 0.5
        //0 - forever
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }

    //start / stop animation when tapped
    @IBAction func tapAction(_ sender: Any) {
        if imageView.isAnimating {
            imageView.stopAnimating()
        } else {
            imageView.startAnimating()
        }
    }
    
}


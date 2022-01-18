//
//  ViewController.swift
//  GradientBackground
//
//  Created by Benny Davidovitz on 18/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupGradientBackgroundForMyView()
        
        let gView = GradientView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        gView.colors = [.black, .red]
        self.view.addSubview(gView)
        
        gradientView.colors = [.blue, .cyan]
        
        UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    }

    private func setupGradientBackgroundForMyView() {
        //view is actually displays a layer
        //layer can have a sublayer(s) and parent layer , just like in UIView world
        //CALayer is root class for all layers
        //CAGradientLayer is a subclass of CALayer
        //CAShapeLayer can display shapes
        //https://developer.apple.com/documentation/quartzcore/cagradientlayer
        //myView.backgroundColor = .clear
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.withAlphaComponent(0.6).cgColor,
                                UIColor.red.withAlphaComponent(0.2).cgColor,
                                UIColor.white.cgColor]
        //layer as something that need to be displayed requires frame (hopefuly not 0)
        //we want the layer to cover all myView
        gradientLayer.frame = myView.bounds
        //start at top left
        gradientLayer.startPoint = CGPoint.zero //0,0
        //end at bottom right
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myView.layer.addSublayer(gradientLayer)
        
    }
    
    //purpose: update gradient layer frame when layout updated
    override func viewDidLayoutSubviews() {
        //in order to keep the implementation of the super class, we call super.something()
        super.viewDidLayoutSubviews()
        
        myView.layer.sublayers?[0].frame = myView.bounds
        //gradientLayer.frame = myView.bounds
    }

}


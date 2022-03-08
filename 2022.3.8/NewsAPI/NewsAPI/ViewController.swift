//
//  ViewController.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 08/03/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Networking.shared.getTopHeadlines { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let articles):
                print(articles)
            }
        }
        
    }


}


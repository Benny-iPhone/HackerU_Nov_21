//
//  TopHeadlinesViewController.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 29/03/2022.
//

import UIKit

class TopHeadlinesViewController: ArticlesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func sendNetworkingRequest() {
        //[weak self] - refere itself weakly, to avoid retain cycle
        Networking.shared.getTopHeadlines(page: self.page) { [weak self] result in
            guard let self = self else { return }
            self.handle(result: result)
        }
    }
    
}

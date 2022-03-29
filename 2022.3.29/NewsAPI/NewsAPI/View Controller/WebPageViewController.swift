//
//  WebPageViewController.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 15/03/2022.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //update title
        navigationItem.title = article.title
        
        //load web page
        if let url = article.url {
            webView.load(URLRequest(url: url))
        } else {
            //unexpected, but if url is nil, pop back
            navigationController?.popViewController(animated: true)
        }

    }
    

}

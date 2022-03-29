//
//  ArticleSourceViewController.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 29/03/2022.
//

import UIKit
import FlagKit

class ArticleSourceViewController: UIViewController {
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //source is optional since you can not set its value when ArticleSourceViewController construed (init)
    //But, we assume that source won't be nil from viewDidLoad, so we can use implicit optional (! and not ?) so compiler will not ask us to check for nullabiliy over and over again
    var source: DetailedSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = source.name
        descriptionLabel.text = source.description
        
        var countryCode = source.country?.uppercased() ?? ""
        if countryCode == "IS" {
            countryCode = "IL"
        }
        
        if let flag = Flag(countryCode: countryCode) {
            flagImageView.image = flag.image(style: .roundedRect)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

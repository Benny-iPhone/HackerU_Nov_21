//
//  SearchResultCell.swift
//  OMDBApi
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func populate(with searchResult: SearchResult) {
        label.text = searchResult.title
        
        if let url = searchResult.poster {
            imageView.sd_setImage(with: url)
        } else {
            imageView.sd_cancelCurrentImageLoad()
            imageView.image = nil
        }
        
    }
    
}

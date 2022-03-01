//
//  PlaceCell.swift
//  PlacesApp
//
//  Created by Benny Davidovitz on 22/02/2022.
//

import UIKit

protocol PlaceCellDelegate: AnyObject {
    
    func placeCellDidPressWaze(_ cell: PlaceCell)
    
}

class PlaceCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    weak var delegate: PlaceCellDelegate?
    
    func populate(with place: Place) {
        label.text = place.name
        
        if let imageName = place.imageName {
            //imageView.image = Database.database.fileController.readImage(with: imageName)
            //[weak self] - capture self (the cell) weakly, so if it was released, we will not capture it alive
            Database.database.fileController.readImageAsync(with: imageName) { [weak self] image in
                self?.imageView.image = image
            }
        } else {
            imageView.image = nil//UIImage(named: "icons8-full_image")
        }
        
        
    }
    
    @IBAction func wazeAction(_ sender: Any) {
        delegate?.placeCellDidPressWaze(self)
    }
    
    
    
}

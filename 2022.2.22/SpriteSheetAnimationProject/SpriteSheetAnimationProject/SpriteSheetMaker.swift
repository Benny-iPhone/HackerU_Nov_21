//
//  SpriteSheetMaker.swift
//  SpriteSheetAnimationProject
//
//  Created by Benny Davidovitz on 22/02/2022.
//

import UIKit

struct SpriteSheetMaker {
    
    static func cropSpriteSheet(image: UIImage, columns: Int, rows: Int) -> [UIImage] {
        
        //understand fixed size for each sub-image
        let width = image.size.width / CGFloat(columns)
        let height = image.size.height / CGFloat(rows)
        
        var results: [UIImage] = []
        for i in 0..<rows {
            for j in 0..<columns {
                //x: index of column multi width
                //y: index of row multi height
                let cropRect = CGRect(x: CGFloat(j) * width, y: CGFloat(i) * height, width: width, height: height)
                //crop is dont in the CoreGraphics image instance (CGImage), that is accesiable vis .cgImage
                if let cgImage = image.cgImage?.cropping(to: cropRect) {
                    //crop was succesful, add to result, convert to UIImage first.
                    results.append(UIImage(cgImage: cgImage))
                }
            }
        }
        
        return results
        
    }
    
}

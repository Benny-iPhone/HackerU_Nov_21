//
//  FileController.swift
//  PlacesApp
//
//  Created by Benny Davidovitz on 22/02/2022.
//

import UIKit

//all operation will be done in document directory of the app sandbox
class FileController {
    
    private var documentDirUrl: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    //receive an image, return its name on disk
    func save(image: UIImage) -> String {
        //determine file name = some unique id + ".jpeg"
        let filename = UUID().uuidString + ".jpeg"
        //convert UIImage to binary data, to jpeg format
        let data = image.jpegData(compressionQuality: 0.7) ?? Data() //~1MB
        //destination url
        let url = documentDirUrl.appendingPathComponent(filename)
        
        //write to disk
        do {
            try data.write(to: url)
        } catch {
            print(error)
        }
        
        return filename
    }
    
    //filename - the name of the file to look for
    //callback - a function to be called 'later' when the result image is ready, on main thread
    func readImageAsync(with filename: String, callback: @escaping (UIImage?)->Void) {
        //work on background thread
        let url = documentDirUrl.appendingPathComponent(filename)
        
        DispatchQueue.global().async {
            let image: UIImage?
            if let data = try? Data(contentsOf: url) {
                image = UIImage(data: data)
            } else {
                image = nil
            }
            //back to main thread
            DispatchQueue.main.async {
                callback(image)
            }
        }
    }
    
    func readImage(with filename: String) -> UIImage? {
        //read binary data
        let url = documentDirUrl.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return UIImage(data: data)
    }
}

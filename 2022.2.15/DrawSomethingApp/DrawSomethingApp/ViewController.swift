//
//  ViewController.swift
//  DrawSomethingApp
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func trashAction(_ sender: Any) {
        drawView.cleanup()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let image = drawView.asImage()
        //self.writeToPhotoAlbum(image: image)
        self.share(image: image)
    }
    
    func share(image: UIImage) {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
}


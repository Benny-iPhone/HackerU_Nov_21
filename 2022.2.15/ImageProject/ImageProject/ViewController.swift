//
//  ViewController.swift
//  ImageProject
//
//  Created by Benny Davidovitz on 15/02/2022.
//

import UIKit
//https://github.com/SDWebImage/SDWebImage
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var urlString: String {
        "https://www.cmaquarium.org/app/uploads/2021/06/2021.04-Nick-Underwater-0001.jpg"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func downloadAction(_ sender: UIButton) {
        guard let url = URL(string: self.urlString) else { return }
        //imageView.sd_setImage(with: url)
        
        imageView.sd_setImage(with: url, placeholderImage: nil, options: .init(rawValue: 0)) { received, total, _ in
            print("received: \(received) | total: \(total)")
            DispatchQueue.main.async {
                self.progressView.progress = Float(received) / Float(total)
            }
        } completed: { image, err, cacheType, url in
            
        }


    }
    
    private func downloadOnBackgroundThread(_ sender: UIButton) {
        guard let url = URL(string: self.urlString) else { return }
        
        sender.isEnabled = false
        //DispatchQueue.global().async - do a job in background thread
        DispatchQueue.global().async { //TBD: weakify
            //read data from url (local/remote)
            guard let data = try? Data(contentsOf: url) else { return }
            //create UIImage from binary data
            let image = UIImage(data: data)
            
            //Do a job on main thread
            DispatchQueue.main.async {
                self.imageView.image = image
                sender.isEnabled = true
            }
        }
    }
    
    private func downloadOnMainThread() {
        //problems: stuck main thread, no progress, not reusable, no caching
        
        guard let url = URL(string: self.urlString) else { return }
        //read data from url (local/remote)
        guard let data = try? Data(contentsOf: url) else { return }
        //create UIImage from binary data
        imageView.image = UIImage(data: data)
    }
    
}


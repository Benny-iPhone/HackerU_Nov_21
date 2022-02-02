//
//  ViewController.swift
//  LocalizedApp
//
//  Created by Benny Davidovitz on 01/02/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //AVAudioPlayer - for playing local files
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var playAudioButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(NSLocalizedString("key", comment: ""))
        print(NSLocalizedString("invalid_key", comment: ""))

        localizeUI()
    }
    
    //show translated test on UI Elements
    private func localizeUI() {
        label.text = "label".localized
        alertButton.setTitle("show_alert".localized, for: .normal)
        playAudioButton.setTitle("play_audio".localized, for: .normal)
    }

    @IBAction func showAlertAction(_ sender: Any) {
        let alertController = UIAlertController(title: "alert.title".localized, message: "alert.message".localized, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "alert.ok".localized, style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func playAudioAction(_ sender: Any) {
        
        if self.audioPlayer == nil {
            //get file url
            //Bunle.main - our app main folder
            guard let url = Bundle.main.url(forResource: "sound_effect", withExtension: "wav") else {
                //file not found
                return
            }
            
            //AVAudioPlayer init may throw exeption, so we use 'try?' - if expection raise, we will receive nil
            //our file is a proper audio file, so we can skip on catching the exact exception error
            self.audioPlayer = try? AVAudioPlayer(contentsOf: url)
        }
        
        self.audioPlayer?.play()
        self.audioPlayer?.volume = 1 
    }
    

}


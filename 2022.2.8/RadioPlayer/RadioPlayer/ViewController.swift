//
//  ViewController.swift
//  RadioPlayer
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var stationsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var playStopButton: UIButton!
    private var player: AVPlayer?
    let stations: [RadioStation] = [.galgalatz, .reshetGimel, .eco99Fm]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStationsUI()
    }
    
    private func setupStationsUI() {
        for i in 0..<stations.count {
            stationsSegmentedControl.setTitle(stations[i].name, forSegmentAt: i)
        }
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func radioStationChangedAction(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        //stat playing, only if playing now
        guard player != nil else {
            return
        }
        
        self.play(station: stations[index])
    }
    
    
    @IBAction func volumeAction(_ sender: UISlider) {
        player?.volume = sender.value
    }
    
    
    @IBAction func playStopAction(_ sender: UIButton) {
        if player == nil {
            //play
            let index = stationsSegmentedControl.selectedSegmentIndex
            self.play(station: stations[index])
            sender.isSelected = true
        } else {
            //stop
            self.stop()
            sender.isSelected = false
        }
        
    }
    
    
    //MARK: - Play / Pause Radio -
    //TBD - play shuold use the same player instance if we are resuming the same station
    func play(station: RadioStation) {
        if player != nil {
            //if currenly playing, pause first
            stop()
        }
        
        guard let url = URL(string: station.urlString) else {
            print("failed to load station \(station) | invalid url")
            return
        }
        
        self.player = AVPlayer(url: url)
        player?.volume = volumeSlider.value
        player?.play()
    }
    /*
    func pause() {
        player?.pause()
    }
    */
    func stop() {
        player?.pause()
        self.player = nil
    }
    
    


}


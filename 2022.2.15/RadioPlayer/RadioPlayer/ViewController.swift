//
//  ViewController.swift
//  RadioPlayer
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
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
        //as a result we must implement UIPickerViewDataSource, UIPickerViewDelegate protocol in ViewController
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func volumeAction(_ sender: UISlider) {
        player?.volume = sender.value
    }
    
    
    @IBAction func playStopAction(_ sender: UIButton) {
        if player == nil {
            //play
            let index = pickerView.selectedRow(inComponent: 0)
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

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //how many wheels
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //rows per wheel
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.stations.count
    }
    
    //test in row (wheel)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.stations[row].name
    }
    
    //think of this as the UIPickerView "IBAction" func
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.play(station: stations[row])
    }
    
}


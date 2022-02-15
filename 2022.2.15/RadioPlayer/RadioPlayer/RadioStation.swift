//
//  RadioStation.swift
//  RadioPlayer
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import Foundation
import UIKit

//RadioStation struct represent a radio station
//List can be potentialy parsed from data retreived from server or file
struct RadioStation {
    
    let urlString: String
    let name: String
    
}

extension RadioStation {
    //pretty static var for easy creation of prepared stations
    //usage: RadioStation.galgalatz
    static var galgalatz: RadioStation {
        RadioStation(urlString: "http://glzicylv01.bynetcdn.com/glglz_mp3", name: "גלגלצ")
    }
    
    static var reshetGimel: RadioStation {
        RadioStation(urlString: "http://kanliveicy.media.kan.org.il/icy/kangimmel_mp3", name: "רשת ג")
    }
    
    static var eco99Fm: RadioStation {
        .init(urlString: "http://eco01.mediacast.co.il/ecolive/99fm/playlist.m3u8", name: "Eco 99 FM")
    }
}

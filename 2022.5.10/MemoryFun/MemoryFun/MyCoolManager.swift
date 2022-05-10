//
//  MyCoolManager.swift
//  MemoryFun
//
//  Created by Benny Davidovitz on 10/05/2022.
//

import Foundation

protocol MyCoolManagerDelegate: AnyObject {
    func somethingHappned()
}

class MyCoolManagerDelegateWrapper {
    weak var delegate: MyCoolManagerDelegate?
    
    init(delegate: MyCoolManagerDelegate) {
        self.delegate = delegate
    }
}

class MyCoolManager {
    
    static let shared = MyCoolManager()

    //private var listeners: [UUID:MyCoolManagerDelegate] = [:]
    private var listeners: [UUID:MyCoolManagerDelegateWrapper] = [:]
    
    
    func addDelegate(_ delegate: MyCoolManagerDelegate) -> UUID {
        let key = UUID()
        self.listeners[key] = MyCoolManagerDelegateWrapper(delegate: delegate)
        return key
    }
    
    func removeDelegate(_ key: UUID) {
        self.listeners[key] = nil
    }
    
//    var array: [MyCoolManagerDelegate] = []
//    weak var delegate: MyCoolManagerDelegate?
    
    func notifyEvent() {
        Array(listeners.values)
            .compactMap{ $0.delegate }
            .forEach{
                $0.somethingHappned()
            }
        
//        Array(listeners.values).forEach{
//            $0.somethingHappned()
//        }
        
//        delegate?.somethingHappned()
//
//        array.forEach{
//            $0.somethingHappned()
//        }
    }
}

//
//  StackImp.swift
//  Threading
//
//  Created by Benny Davidovitz on 10/05/2022.
//

import Foundation

protocol IStack {
    func add(obj: Int)
    func read() -> [Int]
}

class MyStack: IStack {
    
    private var arr: [Int]
    
    private let queue: DispatchQueue
    
    init() {
        self.arr = []
        //self.queue = DispatchQueue(label: "db_queue")
        self.queue = DispatchQueue(label: "db_queue", attributes: .concurrent)
    }
    
    func add(obj: Int) {

        self.queue.async(flags: .barrier) {
            self.arr.append(obj)
        }
//        self.queue.async {
//            self.arr.append(obj)
//        }
    }
    
    func read() -> [Int] {
        var result: [Int] = []
        self.queue.sync {
            result = arr
        }
        return result
    }
    
}


/*
 Now with Actor
 */

actor MyStack2 {
    private var data: [Int] = []
    
    func add(obj: Int) {
        data.append(obj)
    }
    
    func read() -> [Int] {
        return data
    }
}

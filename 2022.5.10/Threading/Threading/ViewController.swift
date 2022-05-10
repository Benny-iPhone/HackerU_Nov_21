//
//  ViewController.swift
//  Threading
//
//  Created by Benny Davidovitz on 10/05/2022.
//

import UIKit

class NumberCreator {

    var counter: Int = 0
    
    func createNumber() -> Int {
        self.counter += 1
        sleep(1)
        return Int.random(in: 0...100)
    }
    
}

class ViewController: UIViewController {

    @MainActor var value: [Int] = []
    
    //queue can host operation
    //if queue is serial, operations will be executed one after another (may not be the same thread)
    //if queue is concurrent, operations will not wait for each other, they can take place simultaneously
    //Every free thread might take an operation and execute it, if no thread is availble, operations will wait.
    
    //Main Queue, is serial queue, its operations will be executed on main thread only.
    
    let numberCreator = NumberCreator()
    let serialQueue: DispatchQueue = DispatchQueue(label: "my_queue2")
    let queue: DispatchQueue = DispatchQueue(label: "my_queue", attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useMyStack2()
        // Do any additional setup after loading the view.
        
        //data race
        /*
        for _ in 0...1_000 {
            DispatchQueue.global().async {
                self.value += [Int.random(in: 0...2000)]
                print(self.value)
            }
        }*/
        
        /*
        for _ in 0...100 {
            queue.async {
                print("\(Date().timeIntervalSince1970) - \(self.numberCreator.createNumber())")
            }
        }
        
        queue.async {
            print("total created \(self.numberCreator.counter)")
        }
        */
    }
    
    func useMyStack2() {
        let myStack2 = MyStack2()
        
        Task {
            for i in 0...1000 {
                await myStack2.add(obj: i)
            }
            let total = await myStack2.read()
            print(total)
        }
        
        
    }

    //Dead Lock
    //A wait for B to finish
    //B can not start until A finish its operation
    
    func funA() {
        self.serialQueue.sync {
            print("doing A")
            self.funB()
        }
    }
    
    func funB() {
        self.serialQueue.sync {
            print("doing B")
        }
    }

}


//
//  StorageManager.swift
//  ReadWriteDisk
//
//  Created by Benny Davidovitz on 04/01/2022.
//

import Foundation

class StorageManager {
    
    func write(data: Data, filename: String) {
        //get url for app's documents folder
        let documentsDirUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentsDirUrl)
        //generate url + "/" + filename
        let fileUrl = documentsDirUrl.appendingPathComponent(filename)
        
        //write function might throw an exception, so wrap it with do/catch block
        do {
            try data.write(to: fileUrl)
        } catch {
            //operation failed
            print(error)
        }
        
        //you can try without catch
        //optional - if you are expecting result - result will be optional
        //if fails - no crash
        //try? data.write(to: fileUrl)
        //if fails - crash
        //try! data.write(to: fileUrl)
    }
    
    func read(filename: String) -> Data? {
        //get url for app's documents folder
        let documentsDirUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //generate url + "/" + filename
        let fileUrl = documentsDirUrl.appendingPathComponent(filename)
        
        //read data from fileUrl, if fails (try?) return nil
        return try? Data(contentsOf: fileUrl)
    }
    
}


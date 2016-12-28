//
//  PList.swift
//  PListExample
//
//  Created by Ben Shockley on 12/6/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation

struct Plist {
    enum PlistError: Error {
        case fileNotWritten
        case fileDoesNotExist
    }
    
    let name: String
    var sourcePath: String? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {
            return .none
        }
        return path
    }
    
    var destPath: String? {
        guard sourcePath != .none else {
            return .none
        }
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (dir as String).appending("\(name).plist")
        }
    
    init?(name: String) {
        self.name = name
        
        let fileManager = FileManager.default
        
        guard let source = sourcePath else {
            return nil
        }
        guard let destination = destPath else {
            return nil
        }
        
        guard fileManager.fileExists(atPath: source) else {
            return nil
        }
        
        if !fileManager.fileExists(atPath: destination) {
            do {
                try fileManager.copyItem(atPath: source, toPath: destination)
            } catch let error as Error {
                print("unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    func getValuesIntPlistFile() -> Dictionary? {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath) {
            guard let dict = PropertyListSerialization.data(fromPropertyList: <#T##Any#>, format: <#T##PropertyListSerialization.PropertyListFormat#>, options: <#T##PropertyListSerialization.WriteOptions#>)
        }
    }
    
}



















































































//
//  FileWriter.swift
//  Reduxgen
//
//  Created by Alex on 3/10/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

struct FileWriter {
    
    func write(toFile file: File, withPath path: String) {
        let fileUrl = URL(fileURLWithPath: path)
        
        do {
            
        } catch {
            print("Write file failed with error: \(error.localizedDescription)")
        }
    }
}

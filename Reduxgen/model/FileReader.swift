//
//  FileReader.swift
//  Reduxgen
//
//  Created by Alexandr Fadeev on 3/9/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

struct FileReader {
    
    func stringFromFile(withName fileName: String) -> String? {

        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            let errorMessage = String(format: "Could not locate file with name: %@", fileName)
            fatalError(errorMessage)
        }
        
        let fileUrl = URL(fileURLWithPath: path)
        
        do {
            return try String(contentsOf: fileUrl)
        } catch {
            print("Failed to read file. Error: \(error.localizedDescription)")
            return nil
        }
    }
}

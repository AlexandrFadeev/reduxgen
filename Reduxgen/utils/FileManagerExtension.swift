//
//  FileManagerExtension.swift
//  Reduxgen
//
//  Created by Alex on 3/11/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

extension FileManager {
    func createDirectory(atURL url: URL, completion: (Bool) -> Void) {
        do {
            try createDirectory(at: url,
                                withIntermediateDirectories: true)
            completion(true)
        } catch {
            completion(false)
        }
    }
}

//
//  StringExtension.swift
//  Reduxgen
//
//  Created by Alex on 3/10/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

extension String {
    var lowercaseFirstLetter: String {
        prefix(1).lowercased() + dropFirst()
    }
}

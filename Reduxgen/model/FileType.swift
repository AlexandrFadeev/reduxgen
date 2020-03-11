//
//  FileType.swift
//  Reduxgen
//
//  Created by Alexandr Fadeev on 3/9/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

enum DomainFileType: String, CaseIterable {
    case state
    case processor
    case result
    case action
    case reducer
}

enum PresentationFileType: String, CaseIterable {
    case viewController
}

enum DataFileType: String, CaseIterable {
    case model
    case repository
}

enum InjectionFileType: String, CaseIterable {
    case assembly
}

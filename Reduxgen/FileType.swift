//
//  FileType.swift
//  Reduxgen
//
//  Created by Alexandr Fadeev on 3/9/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

protocol FileTypeСopyable {
}

enum DomainFileType: String, CaseIterable, FileTypeСopyable {
    case action
    case result
}

enum PresentationFileType: String, CaseIterable, FileTypeСopyable {
    case viewController
}

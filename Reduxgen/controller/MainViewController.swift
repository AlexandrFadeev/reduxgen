//
//  ViewController.swift
//  Reduxgen
//
//  Created by Alex on 3/9/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var moduleNameTextField: NSTextField!
    @IBOutlet weak var networkApiTextField: NSTextField!
    @IBOutlet weak var generateButton: NSButton!
    
    private var defaultUrl: URL {
        let urlString = String(format: "/Users/%@/Downloads/domain", NSUserName())
        return URL(string: urlString)!
    }
    
    private let fileReader = FileReader()
    private let fileWriter = FileWriter()
    
    private let capitalizedModulePlaceholder    = "@^"
    private let lowercasedModulePlaceholder     = "@&"
    private let capitalizaedApiPlaceholder      = "@*^"
    private let lowercasedApiPlaceholder        = "@*&"
    
    private var moduleName: String { moduleNameTextField.stringValue }
    private var networkApiName: String { networkApiTextField.stringValue }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
    }
    
    override var representedObject: Any? {
        didSet {
            
        }
    }
    
    // MARK: - Private methods
    private func setupButtons() {
        //generateButton.isEnabled = false
    }
    
    private func updatedStringReadFromFile(withName name: String) -> String? {
        guard let text = fileReader.stringFromFile(withName: name) else { return nil }
        
        return text.replacingOccurrences(of: capitalizedModulePlaceholder, with: moduleNameTextField.stringValue)
            .replacingOccurrences(of: lowercasedModulePlaceholder, with: moduleNameTextField.stringValue.lowercaseFirstLetter)
            .replacingOccurrences(of: capitalizaedApiPlaceholder, with: networkApiTextField.stringValue)
            .replacingOccurrences(of: lowercasedApiPlaceholder, with: networkApiTextField.stringValue.lowercaseFirstLetter)
    }
    
//    private func createDomainSwiftFiles() {
//        for domainFile in DomainFileType.allCases {
//            guard let updateText = updatedStringReadFromFile(withName: domainFile.rawValue) else { continue }
//
//            let fileNameWithExtension = String(format: "%@%@.swift",
//                                               moduleNameTextField.stringValue.capitalized,
//                                               domainFile.rawValue.capitalized)
//            let file = File(name: fileNameWithExtension, contents: updateText)
//
//            fileWriter.write(toFile: file, withPath: defaultUrl.absoluteString)
//        }
//    }
    
    private func showBrowsePanel() {
        let openPanel = NSOpenPanel()
        
        openPanel.message = "Choose directory"
        openPanel.prompt = "Generate"
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        
        if openPanel.runModal() == NSApplication.ModalResponse.OK {
            guard let resultUrl = openPanel.url else { return }
            let moduleUrl = resultUrl.appendingPathComponent(moduleNameTextField.stringValue)
            generateFiles(withModuleURL: moduleUrl)
        }
    }
    
    private func generateFiles(withModuleURL url: URL) {
        // Creating module dicrectory
        FileManager.default.createDirectory(atURL: url) { isSuccess in
            guard isSuccess else { return }
            
            createDomainFiles(withURL: url)
        }
    }
    
    private func createInjectionFiles(withURL url: URL) {
        
    }
    
    private func createDataFiles(withURL url: URL) {
        
    }
    
    private func presentationFiles(withURL url: URL) {
        
    }
    
    private func createDomainFiles(withURL url: URL) {
        //        for domainFile in DomainFileType.allCases {
        //            guard let updateText = updatedStringReadFromFile(withName: domainFile.rawValue) else { continue }
        //
        //            let fileNameWithExtension = String(format: "%@%@.swift",
        //                                               moduleNameTextField.stringValue.capitalized,
        //                                               domainFile.rawValue.capitalized)
        //            let file = File(name: fileNameWithExtension, contents: updateText)
        //
        //            fileWriter.write(toFile: file, withPath: defaultUrl.absoluteString)
        //        }
    }
}

// MARK: - Actions
extension MainViewController {
    
    @IBAction private func generateAction(_ sender: NSButton) {
        showBrowsePanel()
    }
}

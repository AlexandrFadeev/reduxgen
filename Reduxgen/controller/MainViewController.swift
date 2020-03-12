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
            
            // Generating files and directories for Redux flow such as 'data', 'domain', 'injection', 'presentation'...
            createDomainFiles(withURL: url)
            createInjectionFiles(withURL: url)
            createDataFiles(withURL: url)
            createPresentationFiles(withURL: url)
        }
    }
    
    private func createInjectionFiles(withURL url: URL) {
        let injectionUrl = url.appendingPathComponent("injection")
        FileManager.default.createDirectory(atURL: injectionUrl) { isSuccess in
            guard isSuccess else { return }
            
            for injectionFile in InjectionFileType.allCases {
                guard let updatedText = updatedStringReadFromFile(withName: injectionFile.rawValue) else {
                    continue
                }
                
                let fileNameWithExtension = String(format: "%@%@.swift", moduleName, injectionFile.rawValue.capitalized)
                let file = File(name: fileNameWithExtension, contents: updatedText)
                fileWriter.write(toFile: file, withPath: injectionUrl.absoluteString)
            }
        }
    }
    
    private func createDataFiles(withURL url: URL) {
        let dataUrl = url.appendingPathComponent("data")
        FileManager.default.createDirectory(atURL: dataUrl) { isSuccess in
            guard isSuccess else { return }
            
            for dataFile in DataFileType.allCases {
                guard let updatedText = updatedStringReadFromFile(withName: dataFile.rawValue) else { continue }
                var fileNameWithExtension = ""
                if dataFile == .model {
                    fileNameWithExtension = String(format: "%@.swift", moduleName)
                } else {
                    fileNameWithExtension = String(format: "%@%@.swift", moduleName, dataFile.rawValue.capitalized)
                }
                
                let file = File(name: fileNameWithExtension, contents: updatedText)
                fileWriter.write(toFile: file, withPath: dataUrl.absoluteString)
            }
        }
    }
    
    private func createPresentationFiles(withURL url: URL) {
        let presentationUrl = url.appendingPathComponent("presentation")
        FileManager.default.createDirectory(atURL: presentationUrl) { isSuccess in
            guard isSuccess else { return }
            
            for presentationFile in PresentationFileType.allCases {
                guard let updatedText = updatedStringReadFromFile(withName: presentationFile.rawValue) else { continue }
                
                let fileNameWithExtension = String(format: "%@%@.swift", moduleName, presentationFile.rawValue.capitalized)
                let file = File(name: fileNameWithExtension, contents: updatedText)
                fileWriter.write(toFile: file, withPath: presentationUrl.absoluteString)
            }
        }
    }
    
    private func createDomainFiles(withURL url: URL) {
        let domainUrl = url.appendingPathComponent("domain")
        FileManager.default.createDirectory(atURL: domainUrl) { isSuccess in
            guard isSuccess else { return }
            
            for domainFile in DomainFileType.allCases {
                guard let updatexText = updatedStringReadFromFile(withName: domainFile.rawValue) else {
                    continue
                }
                
                let fileNameWithExtension = String(format: "%@%@.swift", moduleName, domainFile.rawValue.capitalized)
                let file = File(name: fileNameWithExtension, contents: updatexText)
                fileWriter.write(toFile: file, withPath: domainUrl.absoluteString)
            }
        }
    }
}

// MARK: - Actions
extension MainViewController {
    
    @IBAction private func generateAction(_ sender: NSButton) {
        showBrowsePanel()
    }
}

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
    @IBOutlet weak var pathLabel: NSTextField!
    @IBOutlet weak var browseButton: NSButton!
    @IBOutlet weak var generateButton: NSButton!
    
    private var defaultUrl: URL {
        let urlString = String(format: "/Users/%@/Documents", NSUserName())
        return URL(string: urlString)!
    }
    
    private let fileReader = FileReader()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupButtons()
    }
    
    override var representedObject: Any? {
        didSet {
            
        }
    }
    
    // MARK: - Private methods
    private func setupTextFields() {
        pathLabel.stringValue = defaultUrl.absoluteString
    }
    
    private func setupButtons() {
        //generateButton.isEnabled = false
    }
    
    private func readFromFile() {
        guard let text = fileReader.stringFromFile(withName: "processor") else { return }
        
        let updatedText = text.replacingOccurrences(of: "@^", with: moduleNameTextField.stringValue)
            .replacingOccurrences(of: "@&", with: moduleNameTextField.stringValue.lowercased())
        
        print(updatedText)
    }
}

// MARK: - Actions
extension MainViewController {
    
    @IBAction private func generateAction(_ sender: NSButton) {
        readFromFile()
    }
    
    @IBAction private func browseAction(_ sender: NSButton) {
        print("Browse action")
    }
}

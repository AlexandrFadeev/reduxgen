//
//  ViewController.swift
//  Reduxgen
//
//  Created by Alex on 3/9/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var moduleNameTextField: NSTextField!
    @IBOutlet weak var pathLabel: NSTextField!
    @IBOutlet weak var browseButton: NSButton!
    @IBOutlet weak var generateButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupButtons()
    }

    override var representedObject: Any? {
        didSet {
        
        }
    }
    
    private func setupTextFields() {
        let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
        pathLabel.stringValue = homeDirectory.absoluteString
    }
    
    private func setupButtons() {
        generateButton.isEnabled = false
    }
}

// MARK: - Actions
extension MainViewController {
    
    @IBAction private func generateAction(_ sender: NSButton) {
        
    }
    
    @IBAction private func browseAction(_ sender: NSButton) {
        print("Browse action")
    }
    
}

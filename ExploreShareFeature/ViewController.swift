//
//  ViewController.swift
//  ExploreShareFeature
//
//  Created by Karen Natalia on 12/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    let fileName = "newFile.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func saveAction(_ sender: Any) {
        save(text: "This is a new file for test share", toDirectory: documentDirectory(), withFileName: fileName)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        // Share file
        guard let filePath = self.append(toPath: documentDirectory(), withPathComponent: fileName) else {return}
        
        let fileURL = NSURL(fileURLWithPath: filePath)
        var filesToShare = [Any]()
        filesToShare.append(fileURL)
        
        let shareModal = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        shareModal.popoverPresentationController?.sourceView = self.view
        present(shareModal, animated: true)
    }
    
    // Create document directory path
    func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return documentDirectory[0]
    }
    
    // Func to append path component
    func append(toPath path: String, withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            
            return pathURL.absoluteString
        }
        return nil
    }
    
    // Save file text
    func save(text: String, toDirectory directory: String, withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory, withPathComponent: fileName) else {return}
        
        do {
            try text.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Error ", error)
            return
        }
        print("save success")
    }
}


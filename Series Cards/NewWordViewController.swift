//
//  NewWordViewController.swift
//  Series Cards
//
//  Created by Alan Rabelo Martins on 20/04/17.
//  Copyright © 2017 Alan Rabelo Martins. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewWordViewController: UIViewController {

    @IBOutlet weak var textFieldWord: UITextField!
    
    @IBOutlet weak var textFieldTranslation: UITextField!
    
    @IBOutlet weak var textViewDescription: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        textFieldWord.becomeFirstResponder()
    }
    
    @IBAction func dismiss1(_ sender: Any) {
        resignTextFields()
    }
    @IBAction func dismiss2(_ sender: Any) {
        resignTextFields()
    }

    @IBAction func saveWord(_ sender: UIBarButtonItem) {
        resignTextFields()
    }
    
    func resignTextFields()  {
        textFieldWord.resignFirstResponder()
        textFieldTranslation.resignFirstResponder()
        textViewDescription.resignFirstResponder()
    }
    
    @IBAction func exit(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func changedWord(_ sender: Any) {
        if textFieldWord.text! != "" && textFieldTranslation.text! != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func changedTranslation(_ sender: Any) {
        if textFieldWord.text! != "" && textFieldTranslation.text! != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}




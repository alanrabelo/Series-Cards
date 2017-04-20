//
//  NewWordViewController.swift
//  Series Cards
//
//  Created by Alan Rabelo Martins on 20/04/17.
//  Copyright © 2017 Alan Rabelo Martins. All rights reserved.
//

import UIKit

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

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveWord(_ sender: UIBarButtonItem) {
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




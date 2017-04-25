//
//  SignUpViewController.swift
//  Series Cards
//
//  Created by Alan Rabelo Martins on 20/04/17.
//  Copyright © 2017 Alan Rabelo Martins. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class SignInViewController: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func signUp(_ sender: Any) {
        
        if textFieldPassword.text! != "" && textFieldEmail.text! != "" {
            SVProgressHUD.show(withStatus: "Fazendo Login")
            
            FIRAuth.auth()!.signIn(withEmail: textFieldEmail.text!, password: textFieldPassword.text!, completion: { (user, error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                } else {
                    SVProgressHUD.showSuccess(withStatus: "Entrou com sucesso!")
                    self.dismiss(animated: true, completion: self.dismissView(_:))
                }

            })
                    }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

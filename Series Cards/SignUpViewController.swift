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

class SignUpViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPasswordConfirmation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.dismiss()

        

        // Do any additional setup after loading the view.
    }
    @IBAction func signUp(_ sender: Any) {
        
        if textFieldPassword.text! == textFieldPasswordConfirmation.text! && textFieldPassword.text! != nil && textFieldPasswordConfirmation.text! != nil && textFieldEmail.text! != nil {
            SVProgressHUD.show(withStatus: "Cadastrando")
            
            FIRAuth.auth()!.createUser(withEmail: textFieldEmail.text!, password: textFieldPassword.text!) { (user, error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                } else {
                    FIRAuth.auth()?.signIn(withEmail: self.textFieldEmail.text!, password: self.textFieldPassword.text!, completion: { (user, error) in
                        if error != nil {
                            SVProgressHUD.showError(withStatus: error!.localizedDescription)
                        } else {
                            SVProgressHUD.dismiss()
                            SVProgressHUD.show(withStatus: "Loging In")

                        }
                        
                        self.dismissView(self)
                    })
                    SVProgressHUD.showSuccess(withStatus: "Cadastrado com sucesso!")
                    

                }
            }
            
        }
    }

    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

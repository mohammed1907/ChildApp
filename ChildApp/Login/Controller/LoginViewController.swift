//
//  LoginViewController.swift
////  Created by Farghaly on 8/7/20.
//  Copyright © 2020 Test.iosapp. All rights reserved.
//

import UIKit

import AuthenticationServices

import Firebase
class LoginViewController: UIViewController,ASAuthorizationControllerDelegate {
    
    //MARK:- UIOutlets
    
    @IBOutlet weak var emailTF: FormTextField!
    @IBOutlet weak var passwordTF: FormTextField!
    
    //MARK:- Properties
    let viewModel = UserViewModel()
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        passwordTF.addTarget(self, action: #selector(textFieldDidReturn(_:)), for: .editingDidEndOnExit)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK:- Password text field return button
    @objc func textFieldDidReturn(_ textField: UITextField!) {
        textField.resignFirstResponder()
        // Execute additional code
        loginPressed(nil)
    }
    
    @IBAction func loginPressed(_ sender: UIButton?) {
        if validate() {
            showBlockingLoading()
            Auth.auth().signIn(withEmail: emailTF.text ?? "", password: passwordTF.text ?? "") { authResult, error in
                self.hideBlockingLoading()
                
                guard let user = authResult?.user, error == nil else {
                    self.showMessage(message: "\(error?.localizedDescription ?? "Error" )")
                    return
                }
                print("\(user.email!) logged in")
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MapDetailsViewController.identifier) as! MapDetailsViewController
                self.navigationController?.pushViewController(controller, animated: true)
               
            }
            
        }
    }
    
    
    
    //MARK:- Text fields validation
    func validate() -> Bool {
        var valid: Bool = true
        if (emailTF.text?.isEmpty)! {
            emailTF.showError(message: "Field can't be empty")
            valid = false
        }
        if (passwordTF.text?.isEmpty)! {
            passwordTF.showError(message: "Field can't be empty")
            valid = false
        }
        if let isEmailAddressValid = emailTF.text?.isValidEmail(), !isEmailAddressValid {
            emailTF.showError(message: "Enter valid email")
            valid = false
        }
        return valid
    }
    
    
}

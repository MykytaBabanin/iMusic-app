//
//  LoginViewController.swift
//  IMusic
//
//  Created by Mykyta Babanin on 09.05.2022.
//

import Foundation
import Parse
import UIKit

class RegisterViewController: UIViewController {
    private var registerTextField = UITextField()
    private var registerButton = UIButton()
    private var registerPasswordTextField = UITextField()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        testParseConnection()
        view.addSubview(registerButton)
        view.addSubview(registerTextField)
        view.addSubview(registerPasswordTextField)
        setupAutoLayout()
        setupAction()
        setupStyle()
    }
    
    private func setupAutoLayout() {
        registerTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            registerTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            registerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            registerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            registerTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerPasswordTextField.topAnchor.constraint(equalTo: registerTextField.bottomAnchor, constant: 50),
            registerPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            registerPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            registerPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: registerPasswordTextField.bottomAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupStyle() {
        registerButton.titleLabel?.text = "Register"
        registerTextField.placeholder = "Enter your Login"
        registerPasswordTextField.placeholder = "Enter your password"
        registerButton.backgroundColor = #colorLiteral(red: 0.7523134983, green: 1, blue: 0.9446020629, alpha: 1)
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerTextField.layer.borderWidth = 1
        registerTextField.layer.borderColor = UIColor.black.cgColor
        registerPasswordTextField.layer.borderWidth = 1
        registerPasswordTextField.layer.borderColor = UIColor.black.cgColor
        registerPasswordTextField.isSecureTextEntry = true
    }
    
    private func setupAction() {
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc func registerTapped() {
        let user = PFUser()
        user.username = self.registerTextField.text
        user.password = self.registerPasswordTextField.text
        
        user.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                self.displayAlert(withTitle: "Error", message: error.localizedDescription)
            } else {
                self.displayAlert(withTitle: "Success", message: "Account has been successfully created")
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func testParseConnection(){
        let myObj = PFObject(className:"FirstClass")
        myObj["message"] = "Hey ! First message from Swift. Parse is now connected"
        myObj.saveInBackground { (success, error) in
            if(success){
                print("You are connected!")
            }else{
                print("An error has occurred!")
            }
        }
    }
}


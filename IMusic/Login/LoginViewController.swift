//
//  LoginViewController.swift
//  IMusic
//
//  Created by Mykyta Babanin on 09.05.2022.
//

import Foundation
import Parse
import UIKit
import MessageUI

class LoginViewController: UIViewController {
    
    private var loginTextField = UITextField()
    private var loginButton = UIButton()
    private var passwordTextField = UITextField()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        testParseConnection()
        view.addSubview(loginTextField)
        view.addSubview(loginButton)
        view.addSubview(passwordTextField)
        setupAutoLayout()
        setupAction()
        setupStyle()
    }
    
    private func setupAutoLayout() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

        ])
    }
    
    private func setupStyle() {
        loginButton.titleLabel?.text = "Login"
        loginTextField.placeholder = "Enter your login"
        passwordTextField.placeholder = "Enter your password"
        loginButton.backgroundColor = #colorLiteral(red: 0.7523134983, green: 1, blue: 0.9446020629, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupAction() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        PFUser.logInWithUsername(inBackground: self.loginTextField.text!, password: self.passwordTextField.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                self.displayAlert(withTitle: "Login Successful", message: "")
                self.tabBarController?.selectedIndex = 0
            } else {
                self.displayAlert(withTitle: "Error", message: error!.localizedDescription)
            }
        }
        self.view.endEditing(true)
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


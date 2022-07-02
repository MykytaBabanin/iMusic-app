

import Foundation
import UIKit
import Parse

class LogoutViewController: UIViewController {
    private let logoutButton = UIButton()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(logoutButton)
        setupAutoLayout()
        setupAction()
        setupStyle()
    }
    
    private func setupAutoLayout() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupStyle() {
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = #colorLiteral(red: 0.7523134983, green: 1, blue: 0.9446020629, alpha: 1)
    }
    
    private func setupAction() {
        logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
    }
 
    @objc func logoutPressed() {
        PFUser.logOut()
        displayAlert(withTitle: "Logged out", message: "You are successfully logged out")
        tabBarController?.selectedIndex = 0
    }
    
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
}



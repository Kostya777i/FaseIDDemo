//
//  ViewController.swift
//  FaseIDDemo
//
//  Created by Konstantin Losev on 29.10.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!

    @IBAction func authButtonPressed() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with Face ID"
            
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics, localizedReason: reason
            ) { success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        self.statusLabel.text = "Your Biometric Status: \n" + "Failed"
                        self.statusLabel.textColor = .red
                            self.shoeAlert(title: "Ошибка", message: "Попробуйте снова")
                        return
                    }
                    
                    self.statusLabel.text = "Your Biometric Status: \n" + "Logged In"
                    self.statusLabel.textColor = .green
                }
            }
        } else {
            if let error {
                shoeAlert(title: "Нет доступа", message: "\(error.localizedDescription)")
            }
        }
    }
}

extension ViewController {
    private func shoeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(dismissAction)
        present(alert, animated: true )
    }
}

//
//  LoginViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 10.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    
    // MARK: - ViewLiftCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundTouch()
    }
    
    // MARK: - IBAction
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        if emailTextField.text !=  "" {
            // Reset Password
            FUser.resetPasswordFor(email: emailTextField.text!) { (error) in
                if error != nil {
                    // We have error
                    let ac = UIAlertController(title: "Error?", message: "Please enter valid email", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Done", style: .cancel))
                    self.present(ac, animated: true)
                } else {
                    let ac = UIAlertController(title: "Send", message: "Please check your email!", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Done", style: .cancel))
                    self.present(ac, animated: true )
                }
            }
        } else {
            let ac = UIAlertController(title: "Forgot Password", message: "You must enter email!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Done", style: .cancel))
            present(ac,animated: true)
        }
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
      
        if emailTextField.text != "" && passwordTextField.text != "" {
        
            self.showSpinner()
        
            FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error, isEmailVerified) in
                
                if error != nil  {
                    let ac = UIAlertController(title: "Something New Something Wild", message: "Error with Rigister please try again and check your password", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Done", style: .destructive))
                    self.present(ac, animated: true)
                } else if isEmailVerified {
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                      self.removeSpinner()
                    }
                    self.goToApp()
                }else {
                    let ac = UIAlertController(title: "Something New Something Wild", message: "Please verify your email", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Done", style: .destructive))
                    self.present(ac, animated: true)
                }
            }
            
        } else {
            
        }
    }
    
    // MARK: - Setup
    
    private func setBackgroundTouch() {
        imageViewBackground.isUserInteractionEnabled = true
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(backgroundTap))
        imageViewBackground.addGestureRecognizer(tapGesture)
    }
    
    @objc private func backgroundTap() {
        // hide keyboard
        dissmisKeyboard()
    }
    
    // MARK: - DissmissKeyboard
    
    private func dissmisKeyboard() {
        // Dissmis keyboard
        self.view.endEditing(false)
        print("Dissmis")
    }
    
    
    // MARK: - SignInButtonTapped for Create account
    // TODO: - Sign In Button Tapped -
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegisterViewController
        present(vc, animated: true)
    }
    
    // MARK: - Navigation to go in app
    
    private func goToApp() {
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! UITabBarController
        self.present(mainVC, animated: true)
    }
}



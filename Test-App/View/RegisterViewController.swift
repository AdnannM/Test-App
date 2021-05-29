//
//  RegisterViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 10.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var gendreSegmentetContorl: UISegmentedControl!
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    // MARK: - Properties
    
    var isMale = true
    
    var datePicker = UIDatePicker()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupDatePicker()
        
    }
    
    // MARK: - IBAciton
    @IBAction func genderSegmentedValueChanged(_ sender: UISegmentedControl) {
        
        isMale = sender.selectedSegmentIndex == 0 ? true : false
        
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if chechAllFileds() {
            if passwordTextField.text == confirmPasswordTextField.text {
                registerUser()
            } else {
                alertError(title: "Error",
                           message: "Password don't metch.Please try again!")
            }
        } else {
            alertError(title: "Register Fail",
                       message: "Please Fill All TextField")
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Check For data
    private func chechAllFileds() -> Bool {
        return usernameTextField.text != "" && emailTextField.text != "" && cityTextField.text != "" && dateOfBirthTextFiled.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != ""
    }
    
    // MARK: - Set Date Picker
    private func setupDatePicker() {
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        dateOfBirthTextFiled.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.tintColor = UIColor().primaryColor() //chage this for custom color
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(dissmisKeyboard))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        dateOfBirthTextFiled.inputAccessoryView = toolBar
    }
    
    // MARK: - Helpers
    @objc private func handleDatePicker() {
        dateOfBirthTextFiled.text = datePicker.date.longDate()
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
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
   @objc private func dissmisKeyboard() {
        // Dissmis keyboard
        self.view.endEditing(false)
        print("Dissmis")
    }

    
    // MARK: - Register User
    private func registerUser() {
        
        guard let username = usernameTextField.text, let email = emailTextField.text, let city = cityTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else { return }
        
        FUser.registerUserWith(username: username, email: email, city: city, isMale: isMale, password: password, confirmPassword: confirmPassword, dateOfBirth: Date()) { (error) in
            
            if error == nil {
                self.alertError(title: "Something New Something Wild", message: "Verification mail is sent, check you mail")
                self.dismiss(animated: true, completion: nil)
            } else {
                self.alertError(title: "Something New Something Wild", message: "Verification mail is sent, check you mail")
               // Error with Rigister please try again
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Alert For Error (ProgressHUD)
    private func alertError(title: String, message: String) {
        let ac = UIAlertController(title: "Something New Something Wild", message: "Verification mail is sent, check you mail", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Done", style: .destructive))
        self.present(ac, animated: true)
    }
}





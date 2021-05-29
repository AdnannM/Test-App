//
//  ViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 25.03.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    ////////////////////////////////////////////////////////
    // MARK: - Configre Button on WelcomeViewController
    // MARK  -- Action
    ////////////////////////////////////////////////////////
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController!.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.tabBarController!.tabBar.isHidden = false
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
         performSegue(withIdentifier: "goToSignIn", sender: self)
    }
}

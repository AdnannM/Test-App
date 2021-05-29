//
//  ProfileTableViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 21.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    // MARK: - iBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var profileViewBackground: UIView! {
        didSet {
            profileViewBackground.clipsToBounds = true
            profileViewBackground.layer.cornerRadius = 100
            profileViewBackground.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        
    }

   
    // MARK: - iBAction
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        
    }
    
}

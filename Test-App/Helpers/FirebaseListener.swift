//
//  FirebaseListener.swift
//  Test-App
//
//  Created by Adnann Muratovic on 18.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation
import Firebase


// MARK: - Firebase Database save fetch update
// MARK: - Update Firebase database
// MARK: -

class FirebaseListener {

    static let shared = FirebaseListener()
    private init() {}
    
    // MARK: - Check if specific user with id exist in Firebase
    // MARK: - FUser
    
    func downloadCurrentUserFromFirebase(userId: String, email: String) {
        FirebaseReference(.User).document(userId).getDocument { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            if snapshot.exists {
                let user = FUser(_dictionary: snapshot.data()! as NSDictionary)
                user.saveUserLocally()
            } else {
                // First Login
                if let user = userDefaults.object(forKey: kCURRENTUSER) {
                    FUser(_dictionary: user as! NSDictionary).saveUserToFireStore()
                }
            }
        }
    }
}

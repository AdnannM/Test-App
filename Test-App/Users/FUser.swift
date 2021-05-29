//
//  FUser.swift
//  Test-App
//
//  Created by Adnann Muratovic on 11.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation
import Firebase

final class FUser: Equatable {
    static func == (lhs: FUser, rhs: FUser) -> Bool {
        return lhs.objectID == rhs.objectID
    }
    
    // MARK: - User Object
    let objectID: String
    var username: String
    var email: String
    var city: String
    var isMale: Bool
    var dateOfBirth: Date
    var registration = Date()
    
    // MARK: - Inits
    
    init(objectID: String, username: String, email: String, city: String, isMale: Bool, dateOfBirth: Date) {
        self.objectID = objectID
        self.username = username
        self.email = email
        self.city = city
        self.isMale = isMale
        self.dateOfBirth = dateOfBirth
    }
    
    // MARK: - User Dictionary
    
    var userDictionary: NSDictionary {
        return NSDictionary(objects:
            [ self.objectID,
              self.username,
              self.email,
              self.city,
              self.isMale,
              self.dateOfBirth
            ],
                            forKeys:
            [
              kOBJECTID as NSCopying,
              kUSERNAME as NSCopying,
              kEMAIL as NSCopying,
              kCITY as NSCopying,
              kISMALE as NSCopying,
              kDATEOFBIRTH as NSCopying
            
            ])
    }
    
    init(_dictionary: NSDictionary) {
        objectID = _dictionary[kOBJECTID] as? String ?? ""
        username = _dictionary[kUSERNAME] as? String ?? ""
        email = _dictionary[kEMAIL] as? String ?? ""
        city = _dictionary[kCITY] as? String ?? ""
        isMale = _dictionary[kISMALE] as? Bool ?? true
        
        // Convert Timestamp to date
        if let date = _dictionary[kDATEOFBIRTH] as? Timestamp {
            dateOfBirth = date.dateValue()
        } else {
            dateOfBirth = _dictionary[kDATEOFBIRTH] as? Date ?? Date()
        }
    }
    
    // TODO:
    // MARK: - Login User with email and password
    class func loginUserWith(email: String, password: String, completion: @escaping(_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if error == nil {
                if authDataResult!.user.isEmailVerified {
                    // Check if the user exist in database
                    FirebaseListener.shared.downloadCurrentUserFromFirebase(userId: authDataResult!.user.uid, email: email)
                    completion(error, true)
                } else {
                    print("Email is not Verified")
                    completion(error, false)
                }
            } else {
                completion(error, false)
            }
        }
    }
    
    // MARK: - Create User wiht Email and Password
    class func registerUserWith(username: String, email: String, city: String, isMale: Bool, password: String, confirmPassword: String, dateOfBirth: Date, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            
            completion(error)
            
            if error == nil {
                authData!.user.sendEmailVerification(completion: { (error) in
                    print("Auth email verification send")
                })
                
                // MARK: - Create user in datebase
                if authData?.user != nil {
                    let user = FUser(objectID: authData!.user.uid, username: username, email: email, city: city, isMale: isMale, dateOfBirth: dateOfBirth)
                    user.saveUserLocally()
                    print(user)
                }
            }
        }
    }
    
    // TODO:
    // MARK: - Resend Link For Password
    
    class func resetPasswordFor(email: String, completion: @escaping(_ error: Error?) -> Void) {
        
        Auth.auth().currentUser?.reload(completion: { (error) in
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                completion(error)
            })
        })
    }
    
     //  MARK: - Save user Locally before saving to database for checking validation email and username.
    
     func saveUserLocally() {
        
        // MARK: - Save User in UserDefaults
        userDefaults.setValue(self.userDictionary as! [String: Any], forKey: kCURRENTUSER)
        userDefaults.synchronize()
    }
    
    // MARK: - Save user to Firebase
    func saveUserToFireStore() {
        
        FirebaseReference(.User).document(self.objectID).setData(self.userDictionary as! [String : Any]) { (error) in
            if error != nil {
               print(error!.localizedDescription)
            }
        }
    }
}

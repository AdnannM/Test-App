//
//  FCollectionReference.swift
//  Test-App
//
//  Created by Adnann Muratovic on 18.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
}

// MARK: - Root Directory to Firebase

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}

//
//  FirebaseDataClient.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 14/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class Fbc {
    
    static let shared = Firestore.firestore()
    static let settings = FirestoreSettings()
    
    
}
class AuthC {
    static let shared = Auth.auth()
}

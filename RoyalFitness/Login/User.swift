//
//  User.swift
//  RoyalFitness
//
//  Created by Nelson Andrade on 5/12/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit

class User {
    var email : String?
    var uid : String?
    var journalsPath : String?
    
    init(email: String?, uid: String?, journalsPath: String?) {
        self.email = email
        self.uid = uid
        self.journalsPath = journalsPath
    }
    
}


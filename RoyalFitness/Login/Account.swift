//
//  Account.swift
//  RoyalFitness
//
//  Created by Lyndbergh Simelus on 5/13/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit
import Firebase

class Account: UIViewController {

    var ref = Database.database().reference()
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var currentstreak: UILabel!
    
    @IBOutlet weak var longestStreak: UILabel!
    @IBOutlet weak var dateJoined: UILabel!
    
    override func viewDidLoad() {
        ref.child("Users/\(currUser.uid!)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            var dateComponents = DateComponents()
        
            self.username.text = value?["Email"] as? String
            var temp1 = value?["Current Streak"] as? Int
            self.currentstreak.text = "\(temp1!)"
            var temp2 = value?["Longest Streak"] as? Int
            self.longestStreak.text = "\(temp2!)"
            self.dateJoined.text = value?["Date Joined"] as? String
            
        })
        
        super.viewDidLoad()

    }
    

}

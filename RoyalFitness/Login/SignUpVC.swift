//
//  SignUpVC.swift
//  RoyalFitness
//
//  Created by Nelson Andrade on 5/12/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit
import FirebaseAuth


class SignUpVC: UIViewController {

    @IBOutlet weak var register: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passLbl: UILabel!
    @IBOutlet weak var registerLbl: UIButton!
    @IBOutlet weak var loginLbl: UIButton!
    
    @IBOutlet weak var horse: UIImageView!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passtf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register.alpha = 0
        emailLbl.alpha = 0
        passLbl.alpha = 0
        passLbl.alpha = 0
        registerLbl.alpha = 0
        loginLbl.alpha = 0
        emailtf.alpha = 0
        passtf.alpha = 0
        horse.alpha = 0

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animate(withDuration: 0.5) {
            self.register.alpha = 1
            self.emailLbl.alpha = 1
            self.passLbl.alpha = 1
            self.registerLbl.alpha = 1
            self.loginLbl.alpha = 1
            self.emailtf.alpha = 1
            self.passtf.alpha = 1
            self.horse.alpha = 1
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard
            let email = emailtf.text,
            email != "",
            let password = passtf.text,
            password != ""
            
        else {
            AlertController.showALert(inViewController: self, title: "Alert", message: "Please fill out all fields.")
            return
        }
                

        Auth.auth().createUser(withEmail: email, password: password) {
            (user, error) in
                    
            if (user != nil) {
                let date = Date()
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day], from: date)
                
                let a = components.year
                let b = components.month
                let c = components.day
                let all = String(a!) + "-" + String(b!) + "-" + String(c!)
                
                
                let uid = Auth.auth().currentUser!.uid 
                currUser = User(email: email, uid: uid, journalsPath: "Users/\(uid)/Journals")
                ref.child("Users/\(currUser.uid!)").setValue(["Email": email, "Date Joined": all, "Longest Streak": 0, "Current Streak": 0])
                
                ref.child("Users/\(currUser.uid!)").child("LastLogin").child("Year").setValue(Int(a!))
                ref.child("Users/\(currUser.uid!)").child("LastLogin").child("Month").setValue(Int(b!))
                ref.child("Users/\(currUser.uid!)").child("LastLogin").child("Day").setValue(Int(c!))
                
                self.performSegue(withIdentifier: "signedUp", sender: nil)
                print("Signed Up")
            } else if (error != nil) {
                AlertController.showALert(inViewController: self, title: "Error", message: error!.localizedDescription)
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  LoginVC.swift
//  RoyalFitness
//
//  Created by Nelson Andrade on 5/12/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var royal: UILabel!
    @IBOutlet weak var fitness: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passLbl: UILabel!
    @IBOutlet weak var loginLbl: UIButton!
    @IBOutlet weak var registerLbl: UIButton!
    @IBOutlet weak var horse: UIImageView!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passtf: UITextField!
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        royal.alpha = 0
        fitness.alpha = 0
        emailLbl.alpha = 0
        passLbl.alpha = 0
        loginLbl.alpha = 0
        registerLbl.alpha = 0
        emailtf.alpha = 0
        passtf.alpha = 0
        horse.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        UIView.animate(withDuration: 0.5) {
            self.royal.alpha = 1
            self.fitness.alpha = 1
            self.emailLbl.alpha = 1
            self.passLbl.alpha = 1
            self.loginLbl.alpha = 1
            self.registerLbl.alpha = 1
            self.emailtf.alpha = 1
            self.passtf.alpha = 1
            self.horse.alpha = 1
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        guard
            let email = emailtf.text,
            email != "",
            let password = passtf.text,
            password != ""
        else {
            AlertController.showALert(inViewController: self, title: "Alert", message: "Please fill out all fields.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (user != nil) {
                var uid = Auth.auth().currentUser?.uid as! String
                currUser = User(email: email, uid: uid, journalsPath: "Users/\(uid)/Journals")
                self.performSegue(withIdentifier: "loggedIn", sender: self)
                print("log in")
            } else if (error != nil) {
                AlertController.showALert(inViewController: self, title: "Error", message: error!.localizedDescription)
            }
        }
    }
}

//
//  JournalsViewController.swift
//  RoyalFitness
//
//  Created by Nelson Andrade on 4/25/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

var ref = Database.database().reference()
var postData = [JournalModel]()
var elementIds = [String]()
var presentEntry : String?
var presentDate : String?
var myIndex = 0
var currUser : User!

class JournalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Auth.auth().currentUser?.uid as! String)

        // Creating UIBarButtonItem programatically gives you more power to execute actions
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        ref.child(currUser.journalsPath!).observe(.value) { (snapshot) in
            postData.removeAll()
            elementIds.removeAll()

            // must cast snapshot.children.allobjects as array of DataSnapshots because not snapshot is not necessarily an array on its own
            for journal in snapshot.children.allObjects as! [DataSnapshot] {
                                
                elementIds.append(journal.key)  // every entry has a unique id that is auto-generated
                let journalObject = journal.value as! [String: String]  // in JSON we're dealing with keys and values
                
                let entry = journalObject["Entry"]
                let date = journalObject["Date"]
                                
                let data = JournalModel(entry: entry, date: date)
                postData.append(data)
            }
            
            print("POST DATA: ")
            print(postData)
            self.table.reloadData()
         
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalTableViewCell
        
        let element : JournalModel
        element = postData[indexPath.row]
        cell.journalLbl.text = element.date
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        presentEntry = postData[myIndex].entry
        presentDate = postData[myIndex].date
        performSegue(withIdentifier: "segueJournals", sender: self)
    }
    
    @IBAction func unwindToJournals(_ sender: UIStoryboardSegue) {}
    
    @objc func addTapped(sender: UIBarButtonItem) {
        presentEntry = ""
        performSegue(withIdentifier: "segueJournals", sender: self)
    }

}

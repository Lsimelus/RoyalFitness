//
//  JournalEntryViewController.swift
//  RoyalFitness
//
//  Created by Nelson Andrade on 4/25/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit
import FirebaseDatabase

class JournalEntryViewController: UIViewController {
    
    var ref = Database.database().reference()
    
    @IBOutlet weak var entryField: UITextView!
    @IBOutlet weak var dateField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveEntry))
        
        let delete = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteEntry))
        delete.tintColor = .red
        
        navigationItem.rightBarButtonItems = [save, delete]
        
        if presentEntry != "" {
            entryField.text = presentEntry
            dateField.text = presentDate
        } else {
            entryField.becomeFirstResponder()  // Presents keyboard immediately
        }
    }
    
    @objc func saveEntry(sender: UIBarButtonItem) {
        
        if presentEntry != "" {
            ref.child("\(currUser.journalsPath!)/" + elementIds[myIndex]).setValue(["Entry" : entryField.text, "Date" : dateField.text])
            performSegue(withIdentifier: "backToJournals", sender: self)
        } else if entryField.text != "" && dateField.text != "" {
            ref.child(currUser.journalsPath!).childByAutoId().setValue(["Entry" : entryField.text, "Date" : dateField.text])
            performSegue(withIdentifier: "backToJournals", sender: self)
        } else {
            print("Can't save a journal if there's no journal.")
        }
        
    }
    
    @objc func deleteEntry(sender: UIBarButtonItem) {
        if presentEntry != "" {
            print(presentEntry!)
            print("Deleted!")
            ref.child("\(currUser.journalsPath!)/" + elementIds[myIndex]).removeValue()
        }
        performSegue(withIdentifier: "backToJournals", sender: self)
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.destination is JournalsTableViewController else { return }
        guard let journals = segue.destination as? JournalViewController else {
            print("Error in segue")
            return
        }
        journals.modalTransitionStyle = .crossDissolve
        present(journals, animated: true, completion: nil)
    }
 */
    
}

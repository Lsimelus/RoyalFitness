//
//  RunHistory.swift
//  RoyalFitness
//
//  Created by Lyndbergh Simelus on 5/6/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit
import Firebase

class RunHistory: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runs.sort(by: { $0.miles > $1.miles})//sorts runs from best to worst
    }
}

extension RunHistory: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = runs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunCell", for: indexPath) as! RunCell
        cell.setCell(prevrun: video)
        return cell
    }
}

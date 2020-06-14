//
//  RunCell.swift
//  RoyalFitness
//
//  Created by Lyndbergh Simelus on 5/6/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import Foundation

import UIKit

class RunCell: UITableViewCell {
    
    @IBOutlet weak var Mile: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    func setCell(prevrun:PrevRun){
        Mile.text = prevrun.date
        Date.text = prevrun.miles
    }
}

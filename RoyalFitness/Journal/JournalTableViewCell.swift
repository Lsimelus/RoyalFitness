//
//  JournalTableViewCell.swift
//  RoyalFitness
//
//  Created by Nelson Andrade on 5/5/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {

    @IBOutlet weak var journalLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  VideoCell.swift
//  RoyalFitness
//
//  Created by Lyndbergh Simelus on 5/6/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit
import Foundation

var vidNum = ""
class VideoCell: UITableViewCell{


    @IBOutlet weak var videoImageView: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    @IBAction func setUp(_ sender: Any) {
        //Sets the global variable that allows the UIViewC to know which video it should display
        vidNum = videoTitleLabel.text!
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playVid"), object: nil)
        print("sent")
    }
    
    func setVideo(video: Video){//Sets up each VideoCell 
        videoImageView.image = video.image
        videoTitleLabel.text = video.title
    }
}

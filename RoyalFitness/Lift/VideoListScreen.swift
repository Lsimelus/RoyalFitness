//
//  VideoListScreen.swift
//  RoyalFitness
//
//  Created by Lyndbergh Simelus on 5/6/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoListScreen: UIViewController {

    var videos:[Video] = []
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videos = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @objc func proceed() {
        print("~~~~~~~~~~~~~~~")
        print("recieved")
        if vidNum != ""{
            let videoPath = Bundle.main.path(forResource: vidNum, ofType: "mp4")
            if videoPath != nil{
                let VideoPathURL = URL(fileURLWithPath: videoPath!)
                player = AVPlayer(url: VideoPathURL)
                playerViewController.player = player
                vidNum = ""
                self.present(playerViewController, animated: true, completion: nil)
                self.player.play()
            }
        }
        vidNum = ""
    }
    
    @IBAction func analyze(_ sender: Any) {
        NotificationCenter.default.addObserver(self, selector: #selector(proceed), name:  Notification.Name("playVid"), object: nil)
    }
    
    
    func createArray() -> [Video]{
           var tempVideos: [Video] = []
           
        
           let temp2 = UIImage(named: "2")
           let vid2 = Video(image: temp2!, title: "Jumping Jacks")
        
           let temp3 = UIImage(named: "3")
           let vid3 = Video(image: temp3!, title: "Squat")
        
           let temp4 = UIImage(named: "4")
           let vid4 = Video(image:temp4! , title: "Plank Elbows")
        
           let temp5 = UIImage(named: "5")
           let vid5 = Video(image: temp5!, title: "Bicycle")
        
           let temp6 = UIImage(named: "6")
           let vid6 = Video(image: temp6!, title: "Mountain Climbers")
        
           let temp10 = UIImage(named: "10")
           let vid10 = Video(image:temp10! , title: "Push Ups")
        
           let temp25 = UIImage(named: "25")
           let vid25 = Video(image:temp25! , title: "Dips")
        
           let temp27 = UIImage(named: "27")
           let vid27 = Video(image:temp27! , title: "Wall Sits")
        
           let temp28 = UIImage(named: "28")
           let vid28 = Video(image: temp28!, title: "Crunches")
        

        
           tempVideos.append(vid2)
           tempVideos.append(vid3)
           tempVideos.append(vid4)
           tempVideos.append(vid5)
           tempVideos.append(vid6)
           tempVideos.append(vid10)
           tempVideos.append(vid25)
           tempVideos.append(vid27)
           tempVideos.append(vid28)


        
           return tempVideos
       }
    
}
extension VideoListScreen: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let video = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        

        cell.setVideo(video: video)
        
        return cell
    }
}

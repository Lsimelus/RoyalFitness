//
//  RunViewController.swift
//  RoyalFitness
//
//  Created by Lyndbergh Simelus on 5/2/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreLocation

var runs:[PrevRun] = [] //holds the previous runs in the past

class RunViewController: UIViewController , CLLocationManagerDelegate{
    
      let locationManager = CLLocationManager();
      let spotter = Tracker();
      var startTime: DispatchTime = DispatchTime.now()
      var timeInterval:Double = 0.0
      
      var ref = Database.database().reference()
    

      @IBOutlet weak var amph: UILabel!
      @IBOutlet weak var miles: UILabel!
      @IBOutlet weak var time: UILabel!
      
      @IBOutlet weak var PR: UILabel!
      @IBOutlet weak var AVG: UILabel!
      

    
      var LIVE = false
    
    func records(){//Sets PR and AVG
        
        ref.child("Users/\(currUser.uid!)").child("Run").observeSingleEvent(of: .value, with: { (snapshot) in
            var total = 0.0
            var max = 0.0
            var count = 0
            
            let book = snapshot.value as? NSDictionary
            if book != nil{// If the user has ran before
                for (key, value) in book!{
                    if (value as! Double) > max{
                        max = value as! Double
                    }
                    count += 1
                    total += value as! Double
                    
                }
                self.PR.text = self.leaveDecimals(max, 2)
                self.AVG.text = self.leaveDecimals(total/(Double(count)) , 2)
            }
        })
        
    }
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func goRun(_ sender: Any) {
        records()
        locationManager.requestAlwaysAuthorization()

        //For when app is open
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }
        
        if (!LIVE){
            LIVE = true

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest

            startTime = DispatchTime.now()
            locationManager.startUpdatingLocation()
            
            button.setTitle("End Run", for: .normal)

            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runner), userInfo: nil, repeats: true)//Location is updated every 5 seconds
        }else{
            LIVE = false
            button.setTitle("Start New Run", for: .normal)

            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            
            let a = components.year
            let b = components.month
            let c = components.day
            let all = String(a!) + "-" + String(b!) + "-" + String(c!)
            
            //ref.child("Run").childByAutoId().setValue(Double.random(in: 10.0 ..< 20.0))
            ref.child("Run").child(all).setValue(spotter.totalDistance)
            ref.child("Users/\(currUser.uid!)").child("Run").child(all).setValue(spotter.totalDistance)
            
            amph.text = ""
            miles.text = ""
            time.text = ""
            PR.text = ""
            AVG.text = ""
            
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func display(){
        if(LIVE){
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - startTime.uptimeNanoseconds
            timeInterval = Double(nanoTime)/1000000000.0
            self.time.text = timeConverter(timeInterval)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error){
        print(error)
    }
    
    @objc func runner(){
        if (LIVE){
            display()
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let lastlocation = locations.last!
        let total = spotter.add(lastlocation)
        self.miles.text = leaveDecimals(total, 2)
        let perm_s:Double = total/timeInterval
        var mph:Double = (perm_s * 3600)
        if (timeInterval == 0){
            mph = 0.0
        }
        self.amph.text = leaveDecimals(mph, 1)
    }
    
    func timeConverter(_ rawdata:Double) -> String{
        var raw = Float(rawdata)
        let hour = Int(floor(raw/3600))
        raw = raw.truncatingRemainder(dividingBy: 3600)
        let minutes = Int(floor(raw/60))
        var seconds = Int(raw.truncatingRemainder(dividingBy: 60))
        if seconds < 10 {
            let sec = "0" + String(seconds)
            return String(("\(hour):\(minutes):\(sec)"))
        }
        return String(("\(hour):\(minutes):\(seconds)"))
    }
    
    func leaveDecimals(_ num:Double, _ amount: Int32) ->String {
        let temp = String(num) + "00"
        var leta = Array(temp)[0]
        var final = String(leta)
        leta = Array(temp)[1]
        final += String(leta)
        leta = Array(temp)[2]
        final +=  String(leta)
        leta = Array(temp)[3]
        final += String(leta)
        return final
    }
    
    
     @IBAction func goHistory(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try ref.child("Users/\(currUser.uid!)").child("Run").observeSingleEvent(of: .value, with: { (snapshot) in
                let book = snapshot.value as? NSDictionary
                if book != nil{
                    for (key, value) in book!{
                        runs.append(PrevRun(String(key as! String), String(value as! Double)))
                    }
                }
            })
        }
    }
}

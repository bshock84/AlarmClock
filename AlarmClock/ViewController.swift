//
//  ViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/19/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, TimeKeeperDelegate {
    
    
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    let alarmAudioController = SSSAudioController()
    let alarmController = SSSAlarmController.sharedInstance
    //let audioClip = AudioClip.FogHorn
    let clock = SSSClock()
    let notifCenter = NotificationCenter.default
    
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue){
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clock.timeKeeperDelegate = self
        clock.startClock()
        
        notifCenter.addObserver(self, selector: #selector(suspendApp), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }
    

    
    func suspendApp() {
        print("going to the background now")
        clock.stopClock()
    }
    
    func adjustOrientation() {
        if UIDevice.current.orientation == .landscapeRight || UIDevice.current.orientation == .landscapeLeft {
            timeLabel.font = timeLabel.font.withSize(100.0)
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 2000.0).isActive = true
            print("In landscape Mode")
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func updateClockLabel(currentTime: String, weekdayString: String) {
        timeLabel.text = currentTime
        dateLabel.text = weekdayString
        
    }

    func setupView() {
        
    }
}


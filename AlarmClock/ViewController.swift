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
    
    
    @IBOutlet weak var clockLabel: UILabel!
    
    let alarmAudioController = SSSAudioController()
    let audioClip = AudioClip.FogHorn
    let clock = SSSClock()
    let notifCenter = NotificationCenter.default
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //alarmAudioController.playAlarmSound(audioClip: audioClip)
        clock.timeKeeperDelegate = self
        //clock.tick()
        clock.startClock()
        notifCenter.addObserver(self, selector: #selector(suspendApp), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        
        
        
       
        
    }
    
    func suspendApp() {
        print("going to the background now")
        clock.stopClock()
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func updateClockLabel(currentTime: String) {
       clockLabel.text = currentTime
    }

}


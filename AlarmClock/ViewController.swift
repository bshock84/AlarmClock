//
//  ViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/19/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let alarmAudioController = SSSAudioController()
    let audioClip = AudioClip.FogHorn

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        alarmAudioController.playAlarmSound(audioClip: audioClip)
        
        
       
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


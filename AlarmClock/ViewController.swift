//
//  ViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/19/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit
import AVFoundation

//Class Extentions


// UIFont extension code provided by Rudolf Adamkovic on stackExchance.
// https://stackoverflow.com/questions/30854690/how-to-get-monospaced-numbers-in-uilabel-on-ios-9
//
//extension UIFont {
//    
//    var monospacedDigitFont: UIFont {
//        let oldFontDescriptor = fontDescriptor
//        let newFontDescriptor = oldFontDescriptor.monospacedDigitFontDescriptor
//        return UIFont(descriptor: newFontDescriptor, size: 0)
//    }
//    
//}
//
//private extension UIFontDescriptor {
//    
//    var monospacedDigitFontDescriptor: UIFontDescriptor {
//        let fontDescriptorFeatureSettings = [[UIFontFeatureTypeIdentifierKey: kNumberSpacingType, UIFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector]]
//        let fontDescriptorAttributes = [UIFontDescriptorFeatureSettingsAttribute: fontDescriptorFeatureSettings]
//        let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
//        return fontDescriptor
//    }
//    
//}



// Classes

class ViewController: UIViewController, TimeKeeperDelegate {
    
    
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    let alarmAudioController = SSSAudioController()
    //let audioClip = AudioClip.FogHorn
    let clock = SSSClock()
    let notifCenter = NotificationCenter.default
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //clockLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 50.0, weight: 2.0)
        
        
        
        
        clock.timeKeeperDelegate = self
        
        clock.startClock()
        
        
        notifCenter.addObserver(self, selector: #selector(suspendApp), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        //notifCenter.addObserver(self, selector: #selector(adjustOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        
        
        
       
        
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


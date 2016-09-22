//
//  Clock.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/21/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation
import UIKit

protocol TimeKeeperDelegate {
    func updateClockLabel(currentTime: String)
}

protocol TimeKeeper {
    var seconds: Int { get set }
    var minutes: Int { get set }
    var hours : Int { get set }
    var currentTime: String { get set }
    
    func startClock()
    func stopClock()
    func tick()
}

class SSSClock: TimeKeeper {
    
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0
    var currentTime: String = ""
    let calendar = Calendar.current
    let timeZone = TimeZone.current
    var timeKeeperDelegate: TimeKeeperDelegate?
    var timerLoop = Timer()
    
    
    
    
    func startClock() {
        timerLoop = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SSSClock.tick), userInfo: nil, repeats: true)
        timerLoop.fire()
        
        
        
    }
    
    func stopClock() {
        timerLoop.invalidate()
    }
    
    @objc func tick() {
        let systemTime = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .medium
        timeFormatter.locale = Locale(identifier: "en_US")
        currentTime = DateFormatter.localizedString(from: systemTime, dateStyle: .none, timeStyle: .medium)
        timeKeeperDelegate?.updateClockLabel(currentTime: currentTime)
    }
    
//    func updateClockLabel(currentTime: String) {
//        return currentTime
//    }
    
    
}

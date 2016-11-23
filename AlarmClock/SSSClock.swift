//
//  Clock.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/21/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation
import UIKit

// Classes

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
        
        // pulling the
        let systemTime = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US")
        currentTime = DateFormatter.localizedString(from: systemTime, dateStyle: .none, timeStyle: .medium)
        
        timeFormatter.dateFormat = "MM-DD-YYY"
        let weekday = calendar.component(.weekday, from: systemTime)
        
        var weekDayString: String
        
        switch weekday {
            case 1: weekDayString = "Sun"
            case 2: weekDayString = "Mon"
            case 3: weekDayString = "Tue"
            case 4: weekDayString = "Wed"
            case 5: weekDayString = "Thu"
            case 6: weekDayString = "Fri"
            case 7: weekDayString = "Sat"
            default: weekDayString = ""
        }
        
        timeKeeperDelegate?.updateClockLabel(currentTime: currentTime, weekdayString: weekDayString)
    }
    
}



















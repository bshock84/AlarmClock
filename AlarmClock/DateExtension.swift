//
//  DateExtension.swift
//  AlarmClock
//
//  Created by Ben Shockley on 11/17/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func timeFromString(time: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.date(from: time)!
    }
    
    static func stringFromTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: time)
    }
    
    static func compareTimes(time1: Date, time2: Date) -> Bool {
        let time1 = DateFormatter.stringFromTime(time: time1)
        let time2 = DateFormatter.stringFromTime(time: time2)
        
        if time1 == time2 {
            return true
        } else {
            return false
        }
    }
}

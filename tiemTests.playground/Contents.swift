import UIKit

extension DateFormatter {
    static func timeFronString(time: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.date(from: time)!
    }
    
    static func stringFromTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
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


let date1 = DateFormatter.timeFronString(time: "9:00 am")
let date2 = DateFormatter.timeFronString(time: "5:24 am")
let date3 = Date()

let truefalse = DateFormatter.compareTimes(time1: date2, time2: date3)

DateFormatter.stringFromTime(time: date3)































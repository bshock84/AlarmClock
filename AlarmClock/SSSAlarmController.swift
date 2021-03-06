//
//  SSSAlarmController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/30/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//Enums

enum AlarmEditingFuctions: String {
    case setRepeatBehaviour = "Repeats"
    case setAudioClip = "Sound"
}




// Structs

struct Snooze {
    var snoozed: Bool
    var snoozeCounter: Int
    var originalAlarmTime: Date?
}


struct Alarm {
    var alarmFired: Bool = false
    var alarmTime: Date
    var alarmWillRepeat: Bool
    var alarmDaysOfWeeksToRepeat = [
        (dayName: "Monday", shortName: "Mon", active: false),
        (dayName: "Tuesday", shortName: "Tue", active: false),
        (dayName: "Wednesday", shortName: "Wed", active: false),
        (dayName: "Thursday", shortName: "Thu", active: false),
        (dayName: "Friday", shortName: "Fri", active: false),
        (dayName: "Saturday", shortName: "Sat", active: false),
        (dayName: "Sunday", shortName: "Sun", active: false)]
    var alarmIsActivated: Bool
    var alarmSound: AudioClipsModel.AudioClip
     
    var alarmTitle: String
    var snooze = Snooze(snoozed: false, snoozeCounter: 0, originalAlarmTime: nil)
    
    init() {
        alarmTime = DateFormatter.timeFromString(time: "9:00 am")
        alarmWillRepeat = false
        alarmIsActivated = true
        alarmSound = .BuzzBuzz
        alarmTitle = "Alarm"
        
    }
    
    init(alarmTime: Date, alarmWillRepeat: Bool, alarmIsActivated: Bool, alarmSound: AudioClipsModel.AudioClip, alarmTitle: String) {
        self.alarmTime = alarmTime
        self.alarmWillRepeat = alarmWillRepeat
        self.alarmSound = alarmSound
        self.alarmIsActivated = alarmIsActivated
        self.alarmTitle = alarmTitle
        
    }
}


// Classes

class SSSAlarmController {
    let audioController = SSSAudioController()
    var willPushDataDelegate: WillPushDataDelegate?
    
    static let sharedInstance = SSSAlarmController()
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(SSSAlarmController.checkForAlarm(_:)), name: NSNotification.Name(rawValue: "currentTime"), object: nil)
}
    
    
    //TEST CASES **** DELETE THESE WHEN DONE WITH THEM
    let alarm4 = Alarm(
            alarmTime: DateFormatter.timeFromString(time: "9:00 am"),
            alarmWillRepeat: false,
            alarmIsActivated: false,
            alarmSound: .FogHorn,
            alarmTitle: "Alarm 1"
    )
    var existingAlarms: [Alarm] = [
        Alarm(),
        Alarm(
            alarmTime: DateFormatter.timeFromString(time: "10:00 pm"),
            alarmWillRepeat: true,
            alarmIsActivated: true,
            alarmSound: .Aliens,
            alarmTitle: "Alarm 2"
        ),
        Alarm(
            alarmTime: DateFormatter.timeFromString(time: "11:00 am"),
            alarmWillRepeat: false,
            alarmIsActivated: true,
            alarmSound: .BombsAway,
            alarmTitle: "Alarm 3")
    ]
    
    func test() {
        existingAlarms.append(alarm4)
        print(existingAlarms)
    }
    
    // END TEST CASES
    
    let CDManagedObject = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    
    func createNewAlarm() -> (alarm: Alarm?, alarmIndex: Int?) {
        let newAlarm = Alarm()
        let alarmIndex = existingAlarms.count
        existingAlarms.append(newAlarm)
        return (alarm: newAlarm, alarmIndex: alarmIndex)
    }
    
    func editAlarm(alarmID: Int) -> Alarm? {
        if alarmID <= existingAlarms.count {
            let alarmToEdit = existingAlarms[alarmID]
            return alarmToEdit
        } else {
            print(AlarmErrors.alarmNotFound.rawValue)
            return nil
        }
    }
    
    func snoozeAlarm(alarmIndex: Int) {
        //load the currently saved alarms from the database.
        retrieveAlarmsFromDatabase()
        
        //if the snooze button has not been pressed before, stop the alarm, save the original alarm time to the snooze struct, add 9 minutes to the alarm time, increment snoozeCounter, and set snooze to true.
        if existingAlarms[alarmIndex].snooze.snoozed == false {
            audioController.stopAlarm()
            existingAlarms[alarmIndex].snooze.originalAlarmTime = existingAlarms[alarmIndex].alarmTime
            
            let alarmTime = existingAlarms[alarmIndex].alarmTime
            existingAlarms[alarmIndex].alarmTime = alarmTime.addingTimeInterval(9.0 * 60.0)
            
            existingAlarms[alarmIndex].snooze.snoozeCounter += 1
            existingAlarms[alarmIndex].snooze.snoozed = true
            existingAlarms[alarmIndex].alarmIsActivated = true
            existingAlarms[alarmIndex].alarmFired = false
            
            print(existingAlarms[alarmIndex])
        } else {
            audioController.stopAlarm()
            let alarmTime = existingAlarms[alarmIndex].alarmTime
            existingAlarms[alarmIndex].alarmTime = alarmTime.addingTimeInterval(9.0 * 60.0)
            
            existingAlarms[alarmIndex].snooze.snoozeCounter += 1
            existingAlarms[alarmIndex].alarmIsActivated = true
            existingAlarms[alarmIndex].alarmFired = false
            
            print(existingAlarms[alarmIndex])
        }
        
        saveAlarmsToDatabase()
    }
    
    func deleteAlarm(alarm: Int) {
        
        retrieveAlarmsFromDatabase()
        
        //check to make sure the index exists, delete if it does, otherwise print an error.
        if alarm <= existingAlarms.count {
            existingAlarms.remove(at: alarm)
        } else {
            print(AlarmErrors.alarmNotFound.rawValue)
        }
        
        saveAlarmsToDatabase()
    }
    
    func activateAlarm(alarmIndex: Int) {
        
    }
    
    func deactivateAlarm(alarmIndex: Int) {
        
        retrieveAlarmsFromDatabase()
        
        var alarm = existingAlarms[alarmIndex]
        
        if alarm.snooze.snoozed {
            audioController.stopAlarm()
            alarm.alarmTime = alarm.snooze.originalAlarmTime!
            alarm.alarmFired = false
            alarm.alarmIsActivated = false
            alarm.snooze.snoozed = false
            
        } else {
        
            audioController.stopAlarm()
            alarm.alarmIsActivated = false
            alarm.alarmFired = false
        }
        existingAlarms[alarmIndex] = alarm
        
        saveAlarmsToDatabase()
    }
    
    func saveAlarmsToDatabase() {
        
    }
    
    func retrieveAlarmsFromDatabase() {

    }
    
    @objc func checkForAlarm(_ notification: NSNotification) {
        guard let currentTimeString = notification.userInfo?["time"] as? String else {
            print("There was no time attached to this notification")
            return
        }
        let currentTime = DateFormatter.timeFromString(time: currentTimeString)
        
        
        for (index, alarm) in existingAlarms.enumerated() {
            if alarm.alarmIsActivated {
                if DateFormatter.compareTimes(time1: alarm.alarmTime, time2: currentTime) {
                    fireAlarm(alarmIndex: index)
                }
            }
        }
        
    }
    
    func fireAlarm(alarmIndex: Int) {
        let alarmInfo: (title: String, time: String, index: Int)
        alarmInfo.title = existingAlarms[alarmIndex].alarmTitle
        alarmInfo.time = DateFormatter.stringFromTime(time: existingAlarms[alarmIndex].alarmTime)
        alarmInfo.index = alarmIndex
        
        if !existingAlarms[alarmIndex].alarmFired {
            //Load audio file and play it
            
            audioController.prepareAlarmSound(audioClip: existingAlarms[alarmIndex].alarmSound)
            audioController.playAlarm()
            
            existingAlarms[alarmIndex].alarmFired = true
            
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "alarmHasBeenFired"), object: self, userInfo: ["alarmIndex" : alarmIndex])
            
            
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            let visibleVC = getVisibleViewController(rootViewController)
            let alarmAlertView: UIViewController = (rootViewController?.storyboard?.instantiateViewController(withIdentifier: "AlarmAlertViewController"))!
            
            visibleVC?.show(alarmAlertView, sender: visibleVC)
            willPushDataDelegate?.pushData(data: alarmInfo)
            
        } else if existingAlarms[alarmIndex].alarmFired {
            print("Alarm is already firing")
        }
    }
    
    
    
    
    
    //Private Functions
    
    private func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        // this function is courtesy of user ProgrammierTier on stackoverflow.com
        
        
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        
        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
    
//    private func getAlarmID() -> Int{
//        // Creates a unique ID Number for the alarm being created, so that it's easy to keep track of this particular alarm.
//        var IDAvailable: Bool = false
//        var alarmID = 1
//        while IDAvailable == false {
//            for alarm in existingAlarms {
//                if alarm.alarmID == alarmID {
//                    IDAvailable = false
//                    alarmID += 1
//                    break
//                } else {
//                    IDAvailable = true
//                }
//            }
//        }
//        return alarmID
//    }
}

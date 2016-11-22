//
//  SSSAlarmController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/30/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation
import CoreData

//Enums

enum AlarmEditingFuctions: String {
    case setRepeatBehaviour = "Repeats"
    case setAudioClip = "Sound"
}




// Structs

struct Snooze {
    var snoozed: Bool
    var snoozeCounter: Int
    var originalAlarmTime: String?
}


struct Alarm {
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
    
    static let sharedInstance = SSSAlarmController()
    private init() {}
    
    //TEST CASES **** DELETE THESE WHEN DONE WITH THEM
    let alarm4 = Alarm(
            alarmTime: DateFormatter.timeFromString(time: "9:00 am"),
            alarmWillRepeat: false,
            alarmIsActivated: false,
            alarmSound: .FogHorn,
            alarmTitle: "Alarm 1"
    )
    var existingAlarms: [Alarm] = [
        Alarm() ,
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
    
    let audioController = SSSAudioController()
    let CDManagedObject = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    
    func createNewAlarm() -> Alarm {
        let newAlarm = Alarm()
        
        
        return newAlarm
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
    
    func snoozeAlarm(alarmID: Int) {
        //load the currently saved alarms from the database.
        retrieveAlarmsFromDatabase()
        
        //if the snooze button has not been pressed before, stop the alarm, save the original alarm time to the snooze struct, add 9 minutes to the alarm time, increment snoozeCounter, and set snooze to true.
//        if existingAlarms[alarmID].snooze.snoozed == false {
//            audioController.stopAlarm()
//            existingAlarms[alarmID].snooze.originalAlarmTime = existingAlarms[alarmID].alarmTime
//            existingAlarms[alarmID].alarmTime += "9"
//            existingAlarms[alarmID].snooze.snoozeCounter += 1
//            existingAlarms[alarmID].snooze.snoozed = true
//            activateAlarm(alarmIndex: alarmID)
//        } else {
//            audioController.stopAlarm()
//            existingAlarms[alarmID].alarmTime += "9"
//            existingAlarms[alarmID].snooze.snoozeCounter += 1
//            activateAlarm(alarmIndex: alarmID)
//        }
        
        saveAlarmsToDatabase()
    }
    
    func deleteAlarm(alarm: Int) {
        //check to make sure the index exists, delete if it does, otherwise print and error.
        if alarm <= existingAlarms.count {
            existingAlarms.remove(at: alarm)
        } else {
            print(AlarmErrors.alarmNotFound.rawValue)
        }
    }
    
    func activateAlarm(alarmIndex: Int) {
        audioController.prepareAlarmSound(audioClip: existingAlarms[alarmIndex].alarmSound)
    }
    
    func deactivateAlarm(alarmIndex: Int) {
        
    }
    
    func saveAlarmsToDatabase() {
        
    }
    
    func retrieveAlarmsFromDatabase() {

    }
    
    //Private Functions
    
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

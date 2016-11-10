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

enum RepeatIntervalType: String {
    case day = "day"
    case week = "week"
    case month = "month"
    case year = "year"
}

// Structs


struct Alarm {
    var alarmTime: String
    var alarmWillRepeat: Bool
    var alarmRepeatInterval: Int?
    var alarmRepeatIntervalType: RepeatIntervalType?
    var alarmIsActivated: Bool
    var alarmSound: AudioClip
    
    init() {
        alarmTime = "9:00 AM"
        alarmWillRepeat = false
        alarmRepeatInterval = 0
        alarmRepeatIntervalType = nil
        alarmIsActivated = true
        alarmSound = .BuzzBuzz
        
    }
    
    init(alarmTime: String, alarmWillRepeat: Bool, alarmRepeatInterval: Int?, alarmIsActivated: Bool, alarmSound: AudioClip, alarmRepeatIntervalType: RepeatIntervalType?) {
        self.alarmTime = alarmTime
        self.alarmWillRepeat = alarmWillRepeat
        self.alarmRepeatInterval = alarmRepeatInterval
        self.alarmSound = alarmSound
        self.alarmIsActivated = alarmIsActivated
        self.alarmRepeatIntervalType = alarmRepeatIntervalType
    }
}


// Classes

class SSSAlarmController {
    
    static let sharedInstance = SSSAlarmController()
    private init() {}
    
    //TEST CASES **** DELETE THESE WHEN DONE WITH THEM
    let alarm4 = Alarm(
            alarmTime: "12:00 am",
            alarmWillRepeat: false,
            alarmRepeatInterval: nil,
            alarmIsActivated: false,
            alarmSound: .FogHorn,
            alarmRepeatIntervalType: nil
    )
    var existingAlarms: [Alarm] = [
        Alarm() ,
        Alarm(
            alarmTime: "10:00 am",
            alarmWillRepeat: true,
            alarmRepeatInterval: 2,
            alarmIsActivated: true,
            alarmSound: .Aliens,
            alarmRepeatIntervalType: .day
        ),
        Alarm(
            alarmTime: "11:00 am",
            alarmWillRepeat: false,
            alarmRepeatInterval: nil,
            alarmIsActivated: true,
            alarmSound: .BombsAway,
            alarmRepeatIntervalType: nil)
    ]
    
    func test() {
        existingAlarms.append(alarm4)
        print(existingAlarms)
    }
    
    // END TEST CASES
    
    
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
    
    func deleteAlarm(alarm: Int) {
        print(existingAlarms.count)
        print(alarm)
        if alarm <= existingAlarms.count {
            existingAlarms.remove(at: alarm)
        } else {
            print(AlarmErrors.alarmNotFound.rawValue)
        }
    }
    
    func activateAlarm(alarmIndex: Int) {
        
    }
    
    func deactivateAlarm(alarmIndex: Int) {
        
    }
    
    func saveAlarmsToDatabase(alarm: Alarm?) {
        
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

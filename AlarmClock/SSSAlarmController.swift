//
//  SSSAlarmController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/30/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation
import CoreData

// Structs

struct Alarm {
    var alarmID: Int
    var alarmTime: String = "9:00 am"
    var alarmWillRepeat: Bool = false
    var alarmRepeatInterval: Double? = 0
    var alarmIsActivated: Bool = false
    var alarmSound: AudioClip = .BuzzBuzz
    
    init(alarmID: Int) {
        self.alarmID = alarmID
    }
    
    init(alarmID: Int, alarmTime: String, alarmWillRepeat: Bool, alarmRepeatInterval: Double?, alarmIsActivated: Bool, alarmSound: AudioClip) {
        self.alarmID = alarmID
        self.alarmTime = alarmTime
        self.alarmWillRepeat = alarmWillRepeat
        self.alarmRepeatInterval = alarmRepeatInterval
        self.alarmSound = alarmSound
        self.alarmIsActivated = alarmIsActivated
    }
}


// Classes

class SSSAlarmController {
    let alarm4 = Alarm(alarmID: 4, alarmTime: "12:00 am", alarmWillRepeat: false, alarmRepeatInterval: nil, alarmIsActivated: false, alarmSound: .FogHorn)
    var existingAlarms: [Alarm] = [
        Alarm(alarmID: 1),
        Alarm(alarmID: 2, alarmTime: "10:00 am", alarmWillRepeat: true, alarmRepeatInterval: 2.0, alarmIsActivated: true, alarmSound: .Aliens),
        Alarm(alarmID: 3, alarmTime: "11:00 am", alarmWillRepeat: false, alarmRepeatInterval: nil, alarmIsActivated: true, alarmSound: .BombsAway)
    ]
    
    func test() {
        existingAlarms.append(alarm4)
        print(existingAlarms)
    }
    let CDManagedObject = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    func createNewAlarm() -> Alarm {
        
        // Creates a unique ID Number for the alarm being created, so that it's easy to keep track of this particular alarm.
        var IDAvailable: Bool = false
        var alarmID = 1
        while IDAvailable == false {
            alarmID += 1
            print(alarmID)
            if existingAlarms[alarmID] == nil {
                IDAvailable = true
            }
        }
        
        let newAlarm = Alarm(alarmID: alarmID)
        existingAlarms[alarmID] = newAlarm
        
        return newAlarm
    }
    
    func editAlarm(alarmID: Int) -> Alarm? {
        let alarmToEdit = existingAlarms[alarmID]
        return alarmToEdit
    }
    
    func activateAlarm() {
        
    }
    
    func deactivateAlarm() {
        
    }
    
    func saveAlarmsToDatabase(alarm: Alarm?) {
        
    }
    
    func retrieveAlarmsFromDatabase() {

    }
}

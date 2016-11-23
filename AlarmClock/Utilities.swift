//
//  Utilities.swift
//  AlarmClock
//
//  Created by Ben Shockley on 11/22/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation

// Delegates

protocol WillPushDataDelegate {
    func pushData<T>(data: T)
}

protocol TimeKeeperDelegate {
    func updateClockLabel(currentTime: String, weekdayString: String)
}




// Protocols

protocol TimeKeeper {
    var seconds: Int { get set }
    var minutes: Int { get set }
    var hours : Int { get set }
    var currentTime: String { get set }
    
    func startClock()
    func stopClock()
    func tick()
}

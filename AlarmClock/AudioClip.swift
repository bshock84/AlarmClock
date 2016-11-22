//
//  AudioClips.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/19/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation

struct AudioClipsModel {
    
    enum AudioClip: String {
        case FogHorn = "foghorn"
        case RailroadCrosing = "railroadcrossing"
        case BuzzBuzz = "buzzbuzz"
        case WarTime = "wartime"
        case BombsAway = "bombsaway"
        case FireAlarm = "firealarm"
        case TornadoAlly = "tornadoally"
        case MissileCommand = "missilecommand"
        case OldTimeBuzzer = "oldtimebuzzer"
        case Aliens = "aliens"
    }
    
    let audioClipArray: [AudioClip] = [
        .FogHorn,
        .RailroadCrosing,
        .BuzzBuzz,
        .WarTime,
        .BombsAway,
        .FireAlarm,
        .TornadoAlly,
        .MissileCommand,
        .OldTimeBuzzer,
        .Aliens
    ]
}

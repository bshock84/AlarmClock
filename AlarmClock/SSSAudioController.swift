//
//  SSAudioSession.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/19/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Foundation
import AVFoundation



class SSSAudioController {
    
    var audioPlayer = AVAudioPlayer()
    let audioSession = AVAudioSession.sharedInstance()
//    let audioClip: AudioClip
//    
//    init(audioClip: AudioClip) {
//        self.audioClip = audioClip
//    }
    
    func configureAudioSession() {
        let availableCategories = audioSession.availableCategories
        if availableCategories.contains("AVAudioSessionCategoryPlayback") {
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch {
                let audioCategoryError100 = NSError(domain: "Audio category could not be set", code: 100, userInfo: nil)
                print(audioCategoryError100)
                return
            }
        } else {
            let audioCategoryError101 = NSError(domain: "Appropriate audio category could not be found on thie device", code: 101, userInfo: nil)
            print(audioCategoryError101)
            return
        }

    }
    
    func activateAudioSession() {
        configureAudioSession()
        do {
            try audioSession.setActive(true)
        } catch {
            //TODO: Handle this error
        }
        
    }
    
    func deActivateAudioSession() {
        do {
            try audioSession.setActive(false)
        } catch {
            //TODO: Handle this error
        }
        
    }
    
    func prepareAlarmSound(audioClip: AudioClipsModel.AudioClip) {
        let audioFilePath = Bundle.main.path(forResource: audioClip.rawValue, ofType: "mp3")
        let audioFileURL = URL(fileURLWithPath: audioFilePath!)
        activateAudioSession()
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioFileURL)
        } catch {
            let audioPlayerError = NSError(domain: "Could not set the URL for the audio player.", code: 200, userInfo: nil)
            NSLog(audioPlayerError.domain)
            print(audioPlayerError)
            return
        }
        
    }
    
    func playAlarm() {
        audioPlayer.play()
    }
    
    func stopAlarm() {
        audioPlayer.stop()
    }
    
}




























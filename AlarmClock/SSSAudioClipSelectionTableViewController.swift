//
//  SSSAudioClipSelectionTableViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 11/21/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit

class SSSAudioClipSelectionTableViewController: UITableViewController {

    let audioClipsModel = AudioClipsModel()
    var alarmToEdit: (alarm: Alarm?, alarmIndex: Int?)
    let alarmController = SSSAlarmController.sharedInstance
    var willPushDataDelegate: WillPushDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioClipsModel.audioClipArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "audioClipCell", for: indexPath)
        let audioClip = audioClipsModel.audioClipArray[indexPath.row]
        cell.textLabel?.text = audioClip.rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmToEdit.alarm?.alarmSound = audioClipsModel.audioClipArray[indexPath.row]
        willPushDataDelegate?.pushData(data: alarmToEdit)
        dismiss(animated: true, completion: nil)
        
    }

}

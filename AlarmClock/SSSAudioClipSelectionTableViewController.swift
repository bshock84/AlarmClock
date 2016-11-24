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
    let audioController = SSSAudioController()
    
    @IBAction func navBarCancelButton(_ sender: AnyObject) {
        audioController.stopAlarm()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func navBarDoneButton(_ sender: AnyObject) {
        audioController.stopAlarm()
        willPushDataDelegate?.pushData(data: alarmToEdit)
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        audioController.activateAudioSession()
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
        audioController.stopAlarm()
        alarmToEdit.alarm?.alarmSound = audioClipsModel.audioClipArray[indexPath.row]
        audioController.prepareAlarmSound(audioClip: (alarmToEdit.alarm?.alarmSound)!)
        audioController.playAlarm()
    }

}

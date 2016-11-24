//
//  SSSAlarmMenuTableViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 11/17/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit

class SSSAlarmMenuTableViewController: UITableViewController, WillPushDataDelegate {
    
    
    @IBOutlet weak var soundDetailLabel: UILabel!
    @IBOutlet var menuTableOutlet: UITableView!
    @IBOutlet weak var repeatDetailLabel: UILabel!
    
    let alarmController = SSSAlarmController.sharedInstance
    var alarmToEdit: (alarm: Alarm?, alarmIndex: Int?)
    var willPushDataDelegate: WillPushDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setupMenuNavigation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupMenuNavigation() {
        soundDetailLabel.text = alarmToEdit.alarm!.alarmSound.rawValue
        
        var numberOfActive = 0
        var repeatedDays: String = ""
        for day in (alarmToEdit.alarm?.alarmDaysOfWeeksToRepeat)! {
            if day.active == true {
                numberOfActive += 1
                repeatedDays.append(" \(day.shortName) ")
            }
        }
        
        switch numberOfActive {
        case 7 : repeatDetailLabel.text = "Everyday"
        case 0 : repeatDetailLabel.text = "Never"
        default: repeatDetailLabel.text = repeatedDays
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "audioClipSelectionSegue" {
            let destinationVC = segue.destination as! SSSAudioClipSelectionTableViewController
            destinationVC.alarmToEdit = alarmToEdit
            destinationVC.willPushDataDelegate = self
        }
        if segue.identifier == "selectRepeatDaysSegue" {
            let destinationVC = segue.destination as! SSSSelectRepeatDaysTableViewController
            destinationVC.alarmToEdit = alarmToEdit
            destinationVC.willPushDataDelegate = self
        }
    }
    
    
    func pushData<T>(data: T) {
        alarmToEdit = data as! (alarm: Alarm?, alarmIndex: Int?)
        setupMenuNavigation()
        menuTableOutlet.reloadData()
        willPushDataDelegate?.pushData(data: self.alarmToEdit)
    }
    
    

}

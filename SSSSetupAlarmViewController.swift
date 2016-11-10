//
//  SSSSetupAlarmViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/29/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit

class SSSSetupAlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableViewOutlet: UITableView!
    let alarmController = SSSAlarmController.sharedInstance
    
    @IBAction func editAlarmRow(_ sender: AnyObject) {
        if tableViewOutlet.isEditing {
            tableViewOutlet.setEditing(false, animated: true)
            editButton.title = "Edit"
        } else {
            tableViewOutlet.setEditing(true, animated: true)
            tableViewOutlet.allowsMultipleSelection = false
            editButton.title = "Done"
            
            
        }
        
    }
    
    override func viewDidLoad() {
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        super.viewDidLoad()
        //alarmController.test()
        tableViewOutlet.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alarmController.existingAlarms.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("I'm gonna delete you \(indexPath.row)")
            alarmController.deleteAlarm(alarm: indexPath.row)
            tableViewOutlet.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("I touched the accessory button for index \(indexPath.row)")
        
        let alarmToEdit = alarmController.editAlarm(alarmID: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "alarmCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlarmTableViewCell
        let alarm = alarmController.existingAlarms[indexPath.row]
        
        cell.alarmTimeLable.text = alarm.alarmTime
        cell.soundClipLabel.text = alarm.alarmSound.rawValue
        if alarm.alarmIsActivated == true {
            cell.alarmActivatedSwitch.isOn = true
        } else {
            cell.alarmActivatedSwitch.isOn = false
        }
        if alarm.alarmWillRepeat {
            if let intervalInfo = alarm.alarmRepeatInterval {
                cell.alarmRepeatInfoLabel.text = "Alarm repeats every \(intervalInfo) \(alarm.alarmRepeatIntervalType!.rawValue)(s)"
            } else {
                cell.alarmRepeatInfoLabel.text = ""
            }
        } else {
            cell.alarmRepeatInfoLabel.text = "Alarm will not repeat."
        }
        cell.alarmActivatedSwitch.tag = indexPath.row
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

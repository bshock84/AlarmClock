//
//  SSSSetupAlarmViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/29/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit


//Protocols

protocol AlarmWillEditDelegate {
    
    func pushAlarmToViewController(alarm: Alarm)
}

// Classes

class SSSSetupAlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableViewOutlet: UITableView!
    let alarmController = SSSAlarmController.sharedInstance
    var editDelegate: AlarmWillEditDelegate?
    var alarmToEdit: (alarm: Alarm?, alarmIndex: Int?)
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        tableViewOutlet.reloadData()
    }
    
    @IBAction func navBarBackButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "unwindToMainScreen", sender: self)
    }
    
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
    @IBAction func addAlarmButton(_ sender: AnyObject) {
        alarmToEdit = alarmController.createNewAlarm()
        performSegue(withIdentifier: "editAlarmSeque", sender: self)
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
            alarmController.deleteAlarm(alarm: indexPath.row)
            tableViewOutlet.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let alarmToEdit = alarmController.editAlarm(alarmID: indexPath.row) else {
                print(AlarmErrors.alarmNotFound.rawValue)
                return
        }
        self.alarmToEdit.alarm = alarmToEdit
        self.alarmToEdit.alarmIndex = indexPath.row
        performSegue(withIdentifier: "editAlarmSeque", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAlarmSeque" {
            let editVC = segue.destination as! SSSAddAlarmViewController
            editVC.alarmToEdit = alarmToEdit
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "alarmCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlarmTableViewCell
        let alarm = alarmController.existingAlarms[indexPath.row]
        
        cell.alarmTimeLable.text = DateFormatter.stringFromTime(time: alarm.alarmTime)
        cell.soundClipLabel.text = alarm.alarmSound.rawValue
        if alarm.alarmIsActivated == true {
            cell.alarmActivatedSwitch.isOn = true
        } else {
            cell.alarmActivatedSwitch.isOn = false
        }
        if alarm.alarmWillRepeat {
            cell.alarmRepeatInfoLabel.text = "Alarm Will Repeat"
        } else {
            cell.alarmRepeatInfoLabel.text = "Alarm will not repeat."
        }
        cell.alarmActivatedSwitch.tag = indexPath.row
        
        return cell
    }
}

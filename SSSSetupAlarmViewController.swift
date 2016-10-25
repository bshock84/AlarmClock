//
//  SSSSetupAlarmViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/29/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit

class SSSSetupAlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewOutlet: UITableView!
    let alarmController = SSSAlarmController()
    
    
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "alarmCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlarmTableViewCell
        let alarm = alarmController.existingAlarms[indexPath.row]
        
        cell.alarmTimeLable.text = alarm.alarmTime
        cell.soundClipLabel.text = alarm.alarmSound.rawValue
        if alarm.alarmIsActivated == true {
            cell.alarmActivatedSwitch.isOn = true
            print("its true")
        } else {
            print("\(alarm.alarmTime) \(alarm.alarmIsActivated)")
            print("it's not activated")
            cell.alarmActivatedSwitch.isOn = false
        }
        if alarm.alarmWillRepeat {
            if let intervalInfo = alarm.alarmRepeatInterval {
            cell.alarmRepeatInfoLabel.text = "Alarm will repeat every \(intervalInfo) days"
            } else {
                cell.alarmRepeatInfoLabel.text = ""
            }
        } else {
            cell.alarmRepeatInfoLabel.text = ""
        }
        
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

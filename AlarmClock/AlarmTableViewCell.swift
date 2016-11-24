//
//  AlarmTableViewCell.swift
//  AlarmClock
//
//  Created by Ben Shockley on 10/25/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    
    @IBOutlet weak var alarmTimeLable: UILabel!
    @IBOutlet weak var soundClipLabel: UILabel!
    @IBOutlet weak var alarmRepeatInfoLabel: UILabel!
    @IBOutlet weak var alarmActivatedSwitch: UISwitch!
    
    var alarmController = SSSAlarmController.sharedInstance
    
    @IBAction func alarmActivatedSwitchAction(_ sender: UISwitch) {
        
        if alarmController.existingAlarms[sender.tag].alarmIsActivated {
            alarmController.existingAlarms[sender.tag].alarmIsActivated = false
            alarmController.deactivateAlarm(alarmIndex: sender.tag)
        } else {
            alarmController.existingAlarms[sender.tag].alarmIsActivated = true
            alarmController.activateAlarm(alarmIndex: sender.tag)
        }
    }
    
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //let mainViewController = SSSSetupAlarmViewController()
        //sharedAlarmController = mainViewController.alarmController
        
    }
    
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

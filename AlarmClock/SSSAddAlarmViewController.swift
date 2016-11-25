//
//  SSSAddAlarmViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/29/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit




class SSSAddAlarmViewController: UIViewController, WillPushDataDelegate {

    let alarmController = SSSAlarmController.sharedInstance
    var alarmToEdit: (alarm: Alarm?, alarmIndex: Int?)
    let setupAlarmViewController = SSSSetupAlarmViewController()
    
   
    @IBOutlet weak var timePickerOutlet: UIDatePicker!
    @IBOutlet weak var containerViewOutlet: UIView!
    
    @IBAction func deleteAlarmButton(_ sender: AnyObject) {
        alarmController.deleteAlarm(alarm: alarmToEdit.alarmIndex!)
        self.performSegue(withIdentifier: "unwindToSetupAlarmSegue", sender: self)
    }
    @IBAction func timePickerDidChange(_ sender: AnyObject) {
        print(timePickerOutlet.date)
        print(DateFormatter.stringFromTime(time: timePickerOutlet.date))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerOutlet.setDate((alarmToEdit.alarm?.alarmTime)!, animated: true)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alarmMenuSegue" {
            let embeddedVC = segue.destination as! SSSAlarmMenuTableViewController
            embeddedVC.alarmToEdit = self.alarmToEdit
            embeddedVC.willPushDataDelegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushData<T>(data: T) {
        alarmToEdit = data as! (alarm: Alarm?, alarmIndex: Int?)
    }
    

}

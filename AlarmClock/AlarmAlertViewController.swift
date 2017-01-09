//
//  AlarmAlertViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 1/1/17.
//  Copyright © 2017 Ben Shockley. All rights reserved.
//

import UIKit

class AlarmAlertViewController: UIViewController, WillPushDataDelegate {
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    let alarmController = SSSAlarmController.sharedInstance
    
    var alarmIndex: Int? = nil

    @IBAction func snoozeButton(_ sender: AnyObject) {
        alarmController.snoozeAlarm(alarmIndex: alarmIndex!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stopButton(_ sender: AnyObject) {
        alarmController.deactivateAlarm(alarmIndex: alarmIndex!)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmController.willPushDataDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushData<T>(data: T) {
        let alarmInfo = data as! (title: String, time: String, index: Int)
        alarmTitleLabel.text = alarmInfo.title
        alarmTimeLabel.text = alarmInfo.time
        alarmIndex = alarmInfo.index
        
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

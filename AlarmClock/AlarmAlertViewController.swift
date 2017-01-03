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

    @IBAction func snoozeButton(_ sender: AnyObject) {
    }
    
    @IBAction func stopButton(_ sender: AnyObject) {
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
        let alarmInfo = data as! (title: String, time: String)
        alarmTitleLabel.text = alarmInfo.title
        alarmTimeLabel.text = alarmInfo.time        
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

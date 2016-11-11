//
//  SSSAddAlarmViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 9/29/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit




class SSSAddAlarmViewController: UITableViewController, AlarmWillEditDelegate {

    let alarmController = SSSAlarmController.sharedInstance
    var alarmToEdit: Alarm?
    let setupAlarmViewController = SSSSetupAlarmViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlarmViewController.editDelegate = self
        

        print(alarmToEdit)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pushAlarmToViewController(alarm: Alarm) {
        print("deleagate has been called")
        alarmToEdit = alarm
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        //Only 2 rows are needed here for the options that are being used.
//        return 2
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellIdentifier = "AlarmEditFunctions"
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//       // let firstCell = AlarmEditingFuctions(
//        
//       // return cell
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

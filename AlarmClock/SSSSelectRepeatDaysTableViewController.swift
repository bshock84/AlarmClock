//
//  SSSSelectRepeatDaysTableViewController.swift
//  AlarmClock
//
//  Created by Ben Shockley on 11/23/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit

class SSSSelectRepeatDaysTableViewController: UITableViewController {

    var alarmToEdit: (alarm: Alarm?, alarmIndex: Int?)
    var willPushDataDelegate: WillPushDataDelegate?
    
    @IBAction func navBarCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func navBarDoneButton(_ sender: AnyObject) {
        willPushDataDelegate?.pushData(data: alarmToEdit)
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (alarmToEdit.alarm?.alarmDaysOfWeeksToRepeat.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repeatDaysCell", for: indexPath)
        let day = alarmToEdit.alarm?.alarmDaysOfWeeksToRepeat[indexPath.row]
        cell.textLabel?.text = day?.dayName
        
        if day?.active == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            alarmToEdit.alarm?.alarmDaysOfWeeksToRepeat[indexPath.row].active = false
            print("changing it to false")
            print(alarmToEdit.alarm?.alarmDaysOfWeeksToRepeat)
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
             alarmToEdit.alarm?.alarmDaysOfWeeksToRepeat[indexPath.row].active = true
            print("changing it to true")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

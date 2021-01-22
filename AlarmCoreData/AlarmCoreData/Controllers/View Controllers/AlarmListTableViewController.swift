//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by Chris Withers on 1/21/21.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }

        // Configure the cell...
        let currentAlarm = AlarmController.shared.alarms[indexPath.row]
        cell.delegate = self
        cell.alarm = currentAlarm
        cell.updateViews(alarm: currentAlarm)

        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToAlarm" {
            guard let destination = segue.destination as? DetailTableViewController,
                  let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let selectedAlarm = AlarmController.shared.alarms[indexPath.row]
            destination.alarm = selectedAlarm
        }
    }

}

extension AlarmListTableViewController: AlarmTableViewCellDelegate {
    func alarmWasToggled(sender: AlarmTableViewCell, alarm: Alarm) {
        let selectedAlarm = alarm
        AlarmController.shared.toggleIsEnabledFor(alarm: selectedAlarm)
        sender.updateViews(alarm: selectedAlarm)
        tableView.reloadData()
        
    }
}

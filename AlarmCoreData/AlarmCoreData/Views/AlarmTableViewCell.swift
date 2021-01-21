//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Chris Withers on 1/21/21.
//

import UIKit

protocol AlarmTableViewCellDelegate: AnyObject {
    func alarmWasToggled(sender: AlarmTableViewCell, alarm: Alarm)
}

class AlarmTableViewCell: UITableViewCell {

    weak var delegate: AlarmTableViewCellDelegate?
    
    var alarm: Alarm?
    
    @IBOutlet weak var alarmTitleLabel: UILabel!
    
    
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    
    @IBAction func isEnabledSwitchToggled(_ sender: UISwitch) {
        guard let currentAlarm = alarm else { return }
        delegate!.alarmWasToggled(sender: self, alarm: currentAlarm)
    }
    
    
    
    func updateViews(alarm: Alarm){
        
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate?.dateToString()
        
        if alarm.isEnabled {
            isEnabledSwitch.setOn(true, animated: true)
        }else {
            isEnabledSwitch.setOn(false, animated: true)
        }
        
    }

}
extension Date {
    func dateToString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: self)
    }
}

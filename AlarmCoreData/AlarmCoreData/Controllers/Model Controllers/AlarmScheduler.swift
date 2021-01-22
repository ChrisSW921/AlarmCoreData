//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Chris Withers on 1/21/21.
//

import Foundation
import UserNotifications


protocol AlarmSchedulerDelegate: AnyObject {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmSchedulerDelegate {
    func scheduleUserNotifications(for alarm: Alarm){
        
        let content = UNMutableNotificationContent()
        guard let id = alarm.uuidString else {return}
        content.title = "REMINDER"
        content.body = "\(alarm.title ?? "Alarm!")"
        content.sound = .default
        
        guard let date = alarm.fireDate else {return}
        
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (Error) in
            if let error = Error {
                print("Unable to add noticiation request \(error.localizedDescription)")
            }
        }
        
    }
    
    
    func cancelUserNotifications(for alarm: Alarm) {
        guard let id = alarm.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}

//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Chris Withers on 1/21/21.
//

import CoreData

class AlarmController {
    
    static var shared = AlarmController()
    
    var alarms: [Alarm] {
        let fetchRequest: NSFetchRequest<Alarm> = {
             let request = NSFetchRequest<Alarm>(entityName: "Alarm")
             request.predicate = NSPredicate(value: true)
             return request
         }()
         return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func createAlarm(withTitle title: String, isEnabled: Bool, fireDate: Date){
        let newAlarm = Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
        if newAlarm.isEnabled{
            scheduleUserNotifications(for: newAlarm)
        }
        CoreDataStack.saveContext()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        cancelUserNotifications(for: alarm)
        if alarm.isEnabled{
            scheduleUserNotifications(for: alarm)
        }
        CoreDataStack.saveContext()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        if alarm.isEnabled {
            scheduleUserNotifications(for: alarm)
        }else{
            cancelUserNotifications(for: alarm)
            scheduleUserNotifications(for: alarm)
        }
        CoreDataStack.saveContext()
    }
    
    func delete(alarm: Alarm) {
        cancelUserNotifications(for: alarm)
        CoreDataStack.context.delete(alarm)
        CoreDataStack.saveContext()
    }
}

extension AlarmController: AlarmSchedulerDelegate {
    
}

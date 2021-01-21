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
        Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
        CoreDataStack.saveContext()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        CoreDataStack.saveContext()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        CoreDataStack.saveContext()
    }
    
    func delete(alarm: Alarm) {
        CoreDataStack.context.delete(alarm)
        CoreDataStack.saveContext()
    }
}

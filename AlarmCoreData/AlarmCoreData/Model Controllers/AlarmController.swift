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
    
    func createAlarm(withTitle title: String, and fireDate: Date){
        Alarm(title: title, fireDate: fireDate)
        CoreDataStack.saveContext()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        let alarmToUpdate = alarm
        
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        
    }
    
    func delete(alarm: Alarm) {
        
    }
    
    func saveToPersistentStore(){
        
    }
    
    
}

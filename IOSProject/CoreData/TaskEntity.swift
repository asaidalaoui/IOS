//
//  TaskEntity.swift
//  IOSProject
//
//  Created by Ali Darwiche  on 3/18/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit
import CoreData


class TaskEntity {
    private var appDelegate: AppDelegate!
    private var managedContext: NSManagedObjectContext!
    private var day:Day!
    private var task:Task!

    init(task:Task) {
        self.day = task.day
        self.task = task
    }
    
//    init(name:String, date:NSDate, duration:Double, details:String, day:String) {
//        access()
//        self.day = DayEntity(day: day)
//        task = Task(managedContext)
//    }
    
    func access() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func save() {
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func getName() {}
    
    func setName(name:String) {
        access()
        task.name = name
        save()
    }
    
    func getDate() {}
    
    func setDate(date:NSDate) {
        
    }
    
    func getDuration() {}
    
    func setDuration(duration:Double) {
        access()
        day.spentHours -= task.duration
        task.duration = duration
        day.spentHours += duration
        save()
    }
    
    func getDetails() {}
    
    func setDetails(details:String) {
        access()
        task.details = details
        save()
    }
    
    
}

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
    
    func getChecked() {}
    
    func setChecked(isChecked:Bool) {
        access()
        task.isChecked = isChecked
        save()
    }
    
    func getDate() {}
    
    func setDate(date:NSDate) {
        access()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        if day.name == dayOfWeek {
            task.date = date
            save()
        } else {
            DayEntity(day:day).removeTask(task:task)
            task.date = date
            DayEntity(day:dayOfWeek).addTask(task:task)
            day = task.day  //If this causes an error, it will add the same day to day,
            //instead of updating day with the new day. This means that
            //doing addTask didn't alter our current instance of day
            //and that we have to create a getDay method for DayEntity
            //and alter the day ourselves
        }
    }
    
    func getDuration() -> Double {
        return task.duration
    }
    
    func setDuration(duration:Double) {
        access()
        day.spentHours -= task.duration
        task.duration = duration
        day.spentHours += duration
        save()
    }
    
    func getDetails() -> String{
        return task.details
    }
    
    func setDetails(details:String) {
        access()
        task.details = details
        save()
    }
}

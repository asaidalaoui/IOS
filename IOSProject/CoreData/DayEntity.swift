//
//  DayEntity.swift
//  IOSProject
//
//  Created by Ali Darwiche  on 3/17/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit
import CoreData

class DayEntity {
    private var appDelegate: AppDelegate!
    private var managedContext: NSManagedObjectContext!
    private var curUser:User!
    private var days:[Day]!
    
    init(){
        curUser = UserEntity().get(name: UserDefaults.standard.object(forKey: "curUser") as! String)
        let sortDesc = NSSortDescriptor(key: "priority", ascending: true)
        days = curUser.days?.sortedArray(using: [sortDesc]) as! [Day]
    }
    
    func access() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func changeSleep(dayOfWeek:String, sleepHours:Double) -> Bool {
        access()
        let index = getDayIndex(dayOfWeek: dayOfWeek)
        let day = days[index]
        day.sleepHours = sleepHours
        
        //Store change
        days[index] = day
        curUser.days = NSSet(array: days)
        do {
            try managedContext.save()
            return true
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return false
    }
    
    func changeBusy(dayOfWeek:String, busyHours:Double) -> Bool {
        access()
        let index = getDayIndex(dayOfWeek: dayOfWeek)
        let day = days[index]
        day.busyHours = busyHours
        
        //Store change
        days[index] = day
        curUser.days = NSSet(array: days)
        do {
            try managedContext.save()
            return true
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return false
    }

    
    //Helper function that provides the index of a day within the User's days list
    func getDayIndex(dayOfWeek:String) -> Int {
        var index:Int = 0
        switch(dayOfWeek) {
        case "Monday": index = 0
            break
        case "Tuesday": index = 1
            break
        case "Wednesday": index = 2
            break
        case "Thursday": index = 3
            break
        case "Friday": index = 4
            break
        case "Saturday": index = 5
            break
        case "Sunday": index = 7
            break
        default: index = -1
            break
        }
        return index
    }
    
//    func get(name:String) -> Day {}
}


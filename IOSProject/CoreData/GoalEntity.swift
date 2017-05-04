//
//  GoalEntity.swift
//  IOSProject
//
//  Created by Ali Darwiche  on 4/21/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit
import CoreData


class GoalEntity {
    private var appDelegate: AppDelegate!
    private var managedContext: NSManagedObjectContext!
    private var day:Day!
    private var goal:Goal!
    
    init(goal:Goal) {
        self.day = goal.day
        self.goal = goal
    }
    
    //    init(name:String, date:NSDate, duration:Double, details:String, day:String) {
    //        access()
    //        self.day = DayEntity(day: day)
    //        goal = Goal(managedContext)
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
    
    func getName() -> String {
        access()
        return goal.name!
    }
    
    func setName(name:String) {
        access()
        goal.name = name
        save()
    }
    
    func getChecked() -> Bool {
        access()
        return goal.isChecked
    }
    
    func setChecked(isChecked:Bool) {
        access()
        goal.isChecked = isChecked
        save()
    }
    
    func getDate() -> Date{
        access()
        return goal.date as! Date
    }
    
    //Returns false if the day we are trying to assign goal to already has a goal
    //Returns true otherwise
    func setDate(date:NSDate) {
        access()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date as Date)
        print("\(day.name) == \(dayOfWeek)")
        if day.name == dayOfWeek {
            goal.date = date
            save()
        } else {
            let newDay = DayEntity(day:dayOfWeek)
//            if (newDay.hasGoal()){
//                return false
//            }
            _ = DayEntity(day:day).removeGoal(goal:goal)
            goal.date = date
            _ = newDay.addGoal(goal:goal)
            day = goal.day  //If this causes an error, it will add the same day to day,
            //instead of updating day with the new day. This means that
            //doing addGoal didn't alter our current instance of day
            //and that we have to create a getDay method for DayEntity
            //and alter the day ourselves
        }
//        return true
    }
    
    func getDuration() -> Double {
        access()
        return goal.duration
    }
    
    func setDuration(duration:Double) {
        access()
        let day = DayEntity(day:goal.day!)
        day.updateSpent(duration: -goal.duration)
        //        day.spentHours -= goal.duration
        goal.duration = duration
        day.updateSpent(duration: duration)
        //        day.spentHours += duration
        save()
    }
    
    func getDetails() -> String{
        access()
        return goal.details!
    }
    
    func setDetails(details:String) {
        access()
        goal.details = details
        save()
    }
}

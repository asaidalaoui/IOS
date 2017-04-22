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
    //    private var curUser:User!
    //    private var days:[Day]!
    private var day:Day!
    
    init(day:String){
        access()
        let curUser = UserEntity().get(name: UserDefaults.standard.object(forKey: "curUser") as! String)
        let sortDesc = NSSortDescriptor(key: "priority", ascending: true)
        let days = curUser.days?.sortedArray(using: [sortDesc]) as! [Day]
        //        var date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        var index = -1
        var dayOfWeek = ""
        repeat {
            index += 1
            dayOfWeek = formatter.string(from: days[index].date as! Date)
//            print("\(dayOfWeek) \(index)")
        } while day != dayOfWeek
        
        self.day = days[index]
        
        //      check date is valid
        let today = Date()
        let result = Calendar.current.compare(today, to: self.day.date as! Date, toGranularity: .day)
        if result == .orderedDescending {
            updateDay()
        }
    }
    
    init(day:Day) {
        self.day = day
        //        self.curUser = day.user
    }
    
    //Method to check if date is correct
    func updateDay() {
        //Initialize variables
        day.spentHours = 0
        day.sleepHours = 0
        day.busyHours = 0
        
        //Erase goals
        day.removeFromGoals(day.goals!)
        
        //Erase tasks
        day.removeFromTasks(day.tasks!)
        
        //Set date element
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let dayOfWeek = formatter.string(from: day.date as! Date)
        
        var index = -1
        var tempDate = Date()
        var saveDate = Date()
        var tempDayOfWeek = ""
        repeat {
            tempDayOfWeek = formatter.string(from: tempDate)
            saveDate = tempDate
            index += 1
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
        } while  dayOfWeek != tempDayOfWeek
        day.priority = Int16(index)
        day.date = saveDate as NSDate?
        _ = save()
    }
    
    func access() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func save() -> Bool {
        // Commit the changes.
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
    
    func getSleep() -> Double {
        access()
        return day.sleepHours
    }
    
    func setSleep(sleepHours:Double) -> Bool {
        access()
        day.spentHours -= day.sleepHours
        day.sleepHours = sleepHours
        day.spentHours += sleepHours
        
        //Store change
        //        days[index] = day
        //        curUser.days = NSSet(array: days)
        return save()
    }
    
    func getBusy() -> Double {
        access()
        return day.busyHours
    }
    
    func setBusy(busyHours:Double) -> Bool {
        access()
        //        let index = getDayIndex(dayOfWeek: dayOfWeek)
        //        let day = days[index]
        day.spentHours -= day.busyHours
        day.busyHours = busyHours
        day.spentHours += busyHours
        
        //Store change
        //        days[index] = day
        //        curUser.days = NSSet(array: days)
        return save()
    }
    
    func getSpent() -> Double{
        access()
        return day.spentHours
    }
    
    func updateSpent(duration:Double) {
        access()
        day.spentHours += duration
        _ = save()
    }
    
    //Return array of tasks sorted by date. First task in list should be first task in day
    func getTasks() -> [Task]{
        access()
        let sortDesc = NSSortDescriptor(key: "date", ascending: true)
        let tasks = day.tasks?.sortedArray(using: [sortDesc]) as! [Task]
        return tasks
    }
    
    func getTask(name:String) -> Task{
        access()
        let tasks = getTasks()
        for task in tasks {
            if task.name == name {
                return task
            }
        }
        return Task(context: managedContext)
    }
    
    func addTask(name:String, date:NSDate, duration:Double, details:String) -> Bool{
        access()
        let task = getTask(name:name)
        if task.name != name && name != "" {
            // Set the attribute values
            task.name = name
            task.date = date
            task.duration = duration
            task.details = details
            task.isChecked = true
            day.spentHours += duration      //Adding hours task takes to our spentHours count
            day.addToTasks(task)
            return save()
        }
        return false
    }
    
    func addTask(task:Task) {
        access()
        day.spentHours += task.duration
        day.addToTasks(task)
        _ = save()
//        return addTask(name: task.name!, date: task.date!, duration: task.duration, details: task.details!)
    }
    
    func removeTask(task:Task) -> Bool{
        access()
        if task.name == getTask(name: task.name!).name && task.name != "" {
            day.spentHours -= task.duration     //Removing hours task takes from our spentHours count
//            print(day)
            day.removeFromTasks(task)
//            print(day)
            return save()
        }
        return false
    }
    
    //Return array of goals sorted by date. First goal in list should be first goal in day
    func getGoals() -> [Goal]{
        access()
        let sortDesc = NSSortDescriptor(key: "date", ascending: true)
        let goals = day.goals?.sortedArray(using: [sortDesc]) as! [Goal]
        return goals
    }
    
    func getGoal(name:String) -> Goal{
        access()
        let goals = getGoals()
        for goal in goals {
            if goal.name == goal {
                return goal
            }
        }
        return Goal(context: managedContext)
    }
    
    func addGoal(name:String, date:NSDate, duration:Double, details:String) -> Bool{
        access()
        let goal = getGoal(name:name)
        if goal.name != name && name != "" {
            // Set the attribute values
            goal.name = name
            goal.date = date
            goal.duration = duration
            goal.details = details
            goal.isChecked = true
            day.spentHours += duration      //Adding hours goal takes to our spentHours count
            day.addToGoals(goal)
            return save()
        }
        return false
    }
    
    func addGoal(goal:Goal) {
        access()
        day.spentHours += goal.duration
        day.addToGoals(goal)
        _ = save()
    }
    
    func removeGoal(goal:Goal) {
        access()
        if goal.name == getGoal(name: goal.name!).name && goal.name != "" {
            day.spentHours -= goal.duration     //Removing hours goal takes from our spentHours count
            //            print(day)
            day.removeFromGoals(goal)
            //            print(day)
            return save()
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
}


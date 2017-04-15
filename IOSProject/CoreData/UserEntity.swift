//
//  UserEntity.swift
//  IOSProject
//
//  Created by Ali Darwiche  on 3/17/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import UIKit
import CoreData

class UserEntity {
    private var appDelegate: AppDelegate!
    private var managedContext: NSManagedObjectContext!
    
    init(){
    }
    
    func access() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func setPassword(name:String, password:String) -> Bool {
        access()
        let user = get(name:name)
        if user.name == name {
            user.password = password
            do {
                try managedContext.save()
            } catch {
                // what to do if an error occurs?
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
            return true
        }
        return false
    }
    
    func add(name:String, password:String){
        access()
        if get(name:name).name != name {
            let user = User(context: managedContext)
            
            // Set the attribute values
            user.name = name
            user.password = password
            
            // Initialize/add days of the week
            var daysOfWeek:[Day] = []
            var date = Date()
            //            let formatter = DateFormatter().dateFormat = "EEEE"
            //            formatter.dateFormat = "EEEE"
            //            let calendar = Calendar.current
            //            var dateComponent = DateComponents()
            //            dateComponent.day = 1
            for i in 0...6 {
                let day = Day(context: managedContext)
                day.spentHours = 0
                day.sleepHours = 0
                day.busyHours = 0
                day.priority = Int16(i)
                day.date = date as NSDate?
                
                //                let dayOfWeek = formatter.string(from: date)
                //                var index:Int = 0
                //                switch(dayOfWeek) {
                //                case "Monday": index = 0
                //                    break
                //                case "Tuesday": index = 1
                //                    break
                //                case "Wednesday": index = 2
                //                    break
                //                case "Thursday": index = 3
                //                    break
                //                case "Friday": index = 4
                //                    break
                //                case "Saturday": index = 5
                //                    break
                //                case "Sunday": index = 6
                //                    break
                //                default: index = -1
                //                    break
                //                }
                //day.date = findDate(day.name)
                daysOfWeek.append(day)
                
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            }
            user.addToDays(NSSet(array: daysOfWeek))
            
            // Commit the changes.
            do {
                try managedContext.save()
            } catch {
                // what to do if an error occurs?
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    //    func findDate(dayOfWeek:String) -> Date {
    //        let date = Date()
    //        let format = DateFormatter()
    //        //http://www.appcoda.com/nsdate/
    //    }
    
    func remove(name:String) -> Bool{
        access()
        let user = get(name:name)
        if user.name == name {
            managedContext.delete(user as NSManagedObject)
            do {
                try managedContext.save()
                return true
            } catch {
                // what to do if an error occurs?
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
        return false
    }
    
    func get(name:String) -> User {
        access()
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "name == %@", name)
        request.returnsObjectsAsFaults = false
        
        var fetchedResult:[User]? = nil
        do{
            try fetchedResult = managedContext.fetch(request) as [User]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        var user = User(context: managedContext)
        if let results = fetchedResult {
            if results.count > 0 {
                user = results[0]
            }
        }
        return user
    }
}

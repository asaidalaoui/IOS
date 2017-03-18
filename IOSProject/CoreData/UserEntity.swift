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
    
    func changePassword(name:String, password:String) -> Bool {
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
            for i in 0...6 {
                let day = Day(context: managedContext)
                day.spentHours = 0
                day.sleepHours = 0
                day.busyHours = 0
                
                switch(i) {
                case 0: day.name = "Monday"
                    break
                case 1: day.name = "Tuesday"
                    break
                case 2: day.name = "Wednesday"
                    break
                case 3: day.name = "Thursday"
                    break
                case 4: day.name = "Friday"
                    break
                case 5: day.name = "Saturday"
                    break
                case 6: day.name = "Sunday"
                    break
                default: break
                }
                daysOfWeek.append(day)
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

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
    
    init(){
        curUser = UserEntity().get(name: UserDefaults.standard.object(forKey: "curUser") as! String)
    }
    
    func access() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func changeSleep(dayOfWeek:String, sleepHours:Double) -> User {
        access()
//        day = curUser.days[]
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "name == %@", dayOfWeek)
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
        
        var user:User?
        if let results = fetchedResult {
            user = results[0]
        } else {
            user = User()
        }
        return user!
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
        default: break
        }
        return index
    }
    
//    func get(name:String) -> Day {}
}


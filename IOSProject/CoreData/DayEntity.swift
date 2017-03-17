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
        
        var user:User?
        if let results = fetchedResult {
            user = results[0]
        } else {
            user = User()
        }
        return user!
    }
}


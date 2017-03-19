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
    
//    func get
    
}

//
//  Task+CoreDataProperties.swift
//  IOSProject
//
//  Created by Ali Darwiche  on 3/14/17.
//  Copyright © 2017 Abderrahman Said-Alaoui. All rights reserved.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task");
    }

    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var duration: Double
    @NSManaged public var details: String?
    @NSManaged public var isChecked: Bool
    @NSManaged public var day: Day?

}

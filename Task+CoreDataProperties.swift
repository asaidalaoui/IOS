//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Ali Darwiche  on 3/23/17.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var duration: Double
    @NSManaged public var isChecked: Bool
    @NSManaged public var name: String?
    @NSManaged public var day: Day?

}

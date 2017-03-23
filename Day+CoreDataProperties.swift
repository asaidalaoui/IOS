//
//  Day+CoreDataProperties.swift
//  
//
//  Created by Ali Darwiche  on 3/23/17.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day");
    }

    @NSManaged public var busyHours: Double
    @NSManaged public var name: String?
    @NSManaged public var priority: Int16
    @NSManaged public var sleepHours: Double
    @NSManaged public var spentHours: Double
    @NSManaged public var goals: NSSet?
    @NSManaged public var tasks: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for goals
extension Day {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: Goal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: Goal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}

// MARK: Generated accessors for tasks
extension Day {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

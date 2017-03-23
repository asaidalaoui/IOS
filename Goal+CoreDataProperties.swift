//
//  Goal+CoreDataProperties.swift
//  
//
//  Created by Ali Darwiche  on 3/23/17.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var duration: Double
    @NSManaged public var isChecked: Bool
    @NSManaged public var name: String?
    @NSManaged public var day: Day?

}

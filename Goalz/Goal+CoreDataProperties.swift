//
//  Goal+CoreDataProperties.swift
//  Goalz

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var endDate: Date
    @NSManaged public var goalDescription: String
    @NSManaged public var startDate: Date
    @NSManaged public var title: String

}

extension Goal : Identifiable {

}

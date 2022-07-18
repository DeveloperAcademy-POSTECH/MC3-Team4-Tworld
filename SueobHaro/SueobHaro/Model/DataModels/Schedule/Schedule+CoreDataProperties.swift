//
//  Schedule+CoreDataProperties.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/18.
//
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var progress: String?
    @NSManaged public var count: Int16
    @NSManaged public var isCanceled: Bool
    @NSManaged public var classInfo: ClassInfo?

}

extension Schedule : Identifiable {

}

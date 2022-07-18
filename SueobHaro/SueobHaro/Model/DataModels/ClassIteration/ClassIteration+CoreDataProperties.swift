//
//  ClassIteration+CoreDataProperties.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/18.
//
//

import Foundation
import CoreData


extension ClassIteration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassIteration> {
        return NSFetchRequest<ClassIteration>(entityName: "ClassIteration")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var day: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var classInfo: ClassInfo?

}

extension ClassIteration : Identifiable {

}

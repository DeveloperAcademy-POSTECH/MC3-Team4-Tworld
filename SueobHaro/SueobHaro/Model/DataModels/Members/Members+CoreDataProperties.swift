//
//  Members+CoreDataProperties.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/18.
//
//

import Foundation
import CoreData


extension Members {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Members> {
        return NSFetchRequest<Members>(entityName: "Members")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var classInfo: ClassInfo?

}

extension Members : Identifiable {

}

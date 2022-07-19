//
//  ClassInfo+CoreDataProperties.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/18.
//
//

import Foundation
import CoreData


extension ClassInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassInfo> {
        return NSFetchRequest<ClassInfo>(entityName: "ClassInfo")
    }

    @NSManaged public var id: String?
    @NSManaged public var firstDate: Date?
    @NSManaged public var tuition: Int32
    @NSManaged public var tuitionPer: Int16

}

extension ClassInfo : Identifiable {

}

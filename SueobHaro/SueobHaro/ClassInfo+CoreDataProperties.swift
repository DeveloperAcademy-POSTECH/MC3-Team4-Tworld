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

    @NSManaged public var id: UUID?
    @NSManaged public var firstDate: Date?
    @NSManaged public var tuition: Int32
    @NSManaged public var tuitionPer: Int16
    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var location: String?
    @NSManaged public var schedule: NSSet?
    @NSManaged public var classIteration: NSSet?
    @NSManaged public var members: NSSet?
    
    
    public var classIterArray: [ClassIteration] {
        let classIterSet = classIteration as? Set<ClassIteration> ?? []
        
        return Array(classIterSet)
    }
    
    public var membersArray: [Members] {
        let memberSet = members as? Set<Members> ?? []
        
        return Array(memberSet)
    }

}

// MARK: Generated accessors for schedule
extension ClassInfo {

    @objc(addScheduleObject:)
    @NSManaged public func addToSchedule(_ value: Schedule)

    @objc(removeScheduleObject:)
    @NSManaged public func removeFromSchedule(_ value: Schedule)

    @objc(addSchedule:)
    @NSManaged public func addToSchedule(_ values: NSSet)

    @objc(removeSchedule:)
    @NSManaged public func removeFromSchedule(_ values: NSSet)

}

// MARK: Generated accessors for classIteration
extension ClassInfo {

    @objc(addClassIterationObject:)
    @NSManaged public func addToClassIteration(_ value: ClassIteration)

    @objc(removeClassIterationObject:)
    @NSManaged public func removeFromClassIteration(_ value: ClassIteration)

    @objc(addClassIteration:)
    @NSManaged public func addToClassIteration(_ values: NSSet)

    @objc(removeClassIteration:)
    @NSManaged public func removeFromClassIteration(_ values: NSSet)

}

// MARK: Generated accessors for members
extension ClassInfo {

    @objc(addMembersObject:)
    @NSManaged public func addToMembers(_ value: Members)

    @objc(removeMembersObject:)
    @NSManaged public func removeFromMembers(_ value: Members)

    @objc(addMembers:)
    @NSManaged public func addToMembers(_ values: NSSet)

    @objc(removeMembers:)
    @NSManaged public func removeFromMembers(_ values: NSSet)

}

extension ClassInfo : Identifiable {

}

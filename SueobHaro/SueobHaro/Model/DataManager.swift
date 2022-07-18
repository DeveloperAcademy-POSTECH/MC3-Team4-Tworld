//
//  DataManager.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/18.
//

import Foundation
import CoreData


class DataManager {
    // MARK: Singleton
    static let shared = DataManager()
    private init() {}
    
    
    // MARK: CoreData Container
    var container: NSPersistentContainer!
    
    
    // MARK: Data
    var classInfo: [ClassInfo]?
    var schedule: [Schedule]?
    var members: [Members]?
    var classIteration: [ClassIteration]?
    
    
    // MARK: Create
    func addClassInfo(id: String, firstDate: Date, tuition: Int32, tuitionPer: Int16) -> Void {
        let newClassInfo = ClassInfo(context: container.viewContext)
        newClassInfo.id = id
        newClassInfo.firstDate = firstDate
        newClassInfo.tuition = tuition
        newClassInfo.tuitionPer = tuitionPer
        try? container.viewContext.save()
    }
    
    func addSchedule(id: String, count: Int16, endTime: Date, startTime: Date, isCanceled: Bool, progress: String) -> Void {
        let newSchedule = Schedule(context: container.viewContext)
        newSchedule.id = id
        newSchedule.count = count
        newSchedule.endTime = endTime
        newSchedule.startTime = startTime
        newSchedule.isCanceled = isCanceled
        newSchedule.progress = progress
        try? container.viewContext.save()
    }
    
    func addMember(id: String, name: String, phoneNumber: String) -> Void {
        let newMember = Members(context: container.viewContext)
        newMember.id = id
        newMember.name = name
        newMember.phoneNumber = phoneNumber
        try? container.viewContext.save()
    }
    
    func addClassIteration(id: String, day: String, startTime: Date, endTime: Date) -> Void {
        let newClassIteration = ClassIteration(context: container.viewContext)
        newClassIteration.id = id
        newClassIteration.day = day
        newClassIteration.startTime = startTime
        newClassIteration.endTime = endTime
        try? container.viewContext.save()
    }
    
    
    // MARK: Read
    func fetchData(target: DataModel) -> Void {
        switch target {
        case .classInfo:
            classInfo = try? container.viewContext.fetch(ClassInfo.fetchRequest())
        case .schedule:
            schedule = try? container.viewContext.fetch(Schedule.fetchRequest())
        case .members:
            members = try? container.viewContext.fetch(Members.fetchRequest())
        case .classIteration:
            classIteration = try? container.viewContext.fetch(ClassIteration.fetchRequest())
        }
    }
    
    
    // MARK: Update (업데이트 필요한 내용만 값을 넘기고, 업데이트 하지 않는 프로퍼티는 nil을 넘겨주시면 됩니다.)
    func updateClassInfo(target: ClassInfo, id: String?, firstDate: Date?, tuition: Int32?, tuitionPer: Int16?) -> Void {
        if let id = id { target.id = id }
        if let firstDate = firstDate { target.firstDate = firstDate }
        if let tuition = tuition { target.tuition = tuition }
        if let tuitionPer = tuitionPer { target.tuitionPer = tuitionPer }
        try? container.viewContext.save()
    }
    
    func updateSchedule(target: Schedule, id: String?, count: Int16?, endTime: Date?, startTime: Date?, isCanceled: Bool?, progress: String?) -> Void {
        if let id = id { target.id = id }
        if let count = count { target.count = count }
        if let endTime = endTime { target.endTime = endTime }
        if let startTime = startTime { target.startTime = startTime }
        if let isCanceled = isCanceled { target.isCanceled = isCanceled }
        if let progress = progress { target.progress = progress }
        try? container.viewContext.save()
    }
    
    func updateMember(target: Members, id: String?, name: String?, phoneNumber: String?) -> Void {
        if let id = id { target.id = id }
        if let name = name { target.name = name }
        if let phoneNumber = phoneNumber { target.phoneNumber = phoneNumber }
        try? container.viewContext.save()
    }
    
    func updateClassIteration(target: ClassIteration, id: String?, day: String?, startTime: Date?, endTime: Date?) -> Void {
        if let id = id { target.id = id }
        if let day = day { target.day = day }
        if let startTime = startTime { target.startTime = startTime }
        if let endTime = endTime { target.endTime = endTime }
        try? container.viewContext.save()
    }
    
    
    // MARK: Delete
    func deleteData<T>(target: T) -> Void {
        container.viewContext.delete(target as! NSManagedObject)
        try? container.viewContext.save()
    }
}

// MARK: DataModel
enum DataModel {
    case classInfo
    case schedule
    case members
    case classIteration
}

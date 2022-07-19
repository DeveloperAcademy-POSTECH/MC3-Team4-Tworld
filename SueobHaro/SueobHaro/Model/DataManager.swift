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
    func addClassInfo(firstDate: Date, tuition: Int32, tuitionPer: Int16, name: String, color: String, location: String, day: [String], startTime: [Date], endTime: [Date], memberName: [String], memberPhoneNumber: [String]) -> Void {
        let newClassInfo = ClassInfo(context: container.viewContext)
        newClassInfo.id = UUID()
        newClassInfo.firstDate = firstDate
        newClassInfo.tuition = tuition
        newClassInfo.tuitionPer = tuitionPer
        newClassInfo.name = name
        newClassInfo.color = color
        newClassInfo.location = location
        try? container.viewContext.save()
        
        guard max(day.count, startTime.count, endTime.count) == min(day.count, startTime.count, endTime.count) else { fatalError("반복 정보 갯수 불일치") }
        for idx in 0..<day.count {
            addClassIteration(day: day[idx], startTime: startTime[idx], endTime: endTime[idx], classInfo: newClassInfo)
        }
        guard max(memberName.count, memberPhoneNumber.count) == min(memberName.count, memberPhoneNumber.count) else { fatalError("맴버 정보 갯수 불일치") }
        for idx in 0..<memberName.count {
            addMember(name: memberName[idx], phoneNumber: memberPhoneNumber[idx], classInfo: newClassInfo)
        }
    }
    
    func addSchedule(count: Int16, endTime: Date, startTime: Date, isCanceled: Bool, progress: String, classInfo: ClassInfo) -> Void {
        let newSchedule = Schedule(context: container.viewContext)
        newSchedule.id = UUID()
        newSchedule.count = count
        newSchedule.endTime = endTime
        newSchedule.startTime = startTime
        newSchedule.isCanceled = isCanceled
        newSchedule.progress = progress
        newSchedule.classInfo = classInfo
        try? container.viewContext.save()
    }
    
    func addMember(name: String, phoneNumber: String, classInfo: ClassInfo) -> Void {
        let newMember = Members(context: container.viewContext)
        newMember.id = UUID()
        newMember.name = name
        newMember.phoneNumber = phoneNumber
        newMember.classInfo = classInfo
        try? container.viewContext.save()
    }
    
    func addClassIteration(day: String, startTime: Date, endTime: Date, classInfo: ClassInfo) -> Void {
        let newClassIteration = ClassIteration(context: container.viewContext)
        newClassIteration.id = UUID()
        newClassIteration.day = day
        newClassIteration.startTime = startTime
        newClassIteration.endTime = endTime
        newClassIteration.classInfo = classInfo
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
    func updateClassInfo(target: ClassInfo, firstDate: Date?, tuition: Int32?, tuitionPer: Int16?, name: String?, color: String?, location: String?) -> Void {
        if let firstDate = firstDate { target.firstDate = firstDate }
        if let tuition = tuition { target.tuition = tuition }
        if let tuitionPer = tuitionPer { target.tuitionPer = tuitionPer }
        if let name = name { target.name = name }
        if let color = color { target.color = color }
        if let location = location { target.location = location }
        try? container.viewContext.save()
    }
    
    func updateSchedule(target: Schedule, count: Int16?, endTime: Date?, startTime: Date?, isCanceled: Bool?, progress: String?) -> Void {
        if let count = count { target.count = count }
        if let endTime = endTime { target.endTime = endTime }
        if let startTime = startTime { target.startTime = startTime }
        if let isCanceled = isCanceled { target.isCanceled = isCanceled }
        if let progress = progress { target.progress = progress }
        try? container.viewContext.save()
    }
    
    func updateMember(target: Members, name: String?, phoneNumber: String?) -> Void {
        if let name = name { target.name = name }
        if let phoneNumber = phoneNumber { target.phoneNumber = phoneNumber }
        try? container.viewContext.save()
    }
    
    func updateClassIteration(target: ClassIteration, day: String?, startTime: Date?, endTime: Date?) -> Void {
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
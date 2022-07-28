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
    @Published var classInfo: [ClassInfo]?
    @Published var schedule: [Schedule]?
    @Published var members: [Members]?
    @Published var classIteration: [ClassIteration]?
    @Published var schools: [School]?
    
    // MARK: Create
    func addClassInfo(firstDate: Date, tuition: Int32, tuitionPer: Int16, name: String, color: String?, location: String?, day: [String], startTime: [Date], endTime: [Date], memberName: [String], memberPhoneNumber: [String]?, memberSchool: [String]) -> Void {
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
        guard max(memberName.count, memberPhoneNumber!.count) == min(memberName.count, memberPhoneNumber!.count),
              max(memberName.count, memberSchool.count) == min(memberName.count, memberSchool.count)
        else { fatalError("맴버 정보 갯수 불일치") }
        for idx in 0..<memberName.count {
            addMember(name: memberName[idx],
                      phoneNumber: memberPhoneNumber![idx],
                      classInfo: newClassInfo,
                      schoolString: memberSchool[idx]
            )
        }
        for idx in 0..<day.count {
            addSchedule(count: 1, endTime: endTime[idx], startTime: startTime[idx], isCanceled: false, progress: "", classInfo: newClassInfo)
            
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
    
    func addMember(name: String, phoneNumber: String, classInfo: ClassInfo, schoolString: String) -> Void {
        let newMember = Members(context: container.viewContext)
        newMember.id = UUID()
        newMember.name = name
        newMember.phoneNumber = phoneNumber
        newMember.classInfo = classInfo
        
        let school = schools?.filter({ $0.name ?? "" == schoolString })
        
        if school?.isEmpty ?? true {
            newMember.school = addSchool(name: schoolString)
        } else {
            newMember.school = school!.first!
        }
        
        try? container.viewContext.save()
    }
    
    func addSchool(name: String) -> School {
        let newSchool = School(context: container.viewContext)
        newSchool.id = UUID()
        newSchool.name = name
        try? container.viewContext.save()
        return newSchool
    }
    
    func addExamPeriod(name: String, start startDate: Date, end endDate: Date, infos: [String] = [], school: School) {
        let newExamPeriod = ExamPeriod(context: container.viewContext)
        newExamPeriod.id = UUID()
        newExamPeriod.name = name
        let dates = Calendar.current.generateDates(inside: DateInterval(start: startDate, end: endDate),
                                       matching: DateComponents(hour: 0, minute: 0, second: 0))
        for (i, date) in dates.enumerated() {
            addExamInfo(examPeriod: newExamPeriod, date: date, text: infos[i])
        }
        newExamPeriod.school = school
        try? container.viewContext.save()
    }
    
    func addExamInfo(examPeriod: ExamPeriod, date: Date, text: String) -> Void {
        let newExamInfo = ExamInfo(context: container.viewContext)
        newExamInfo.id = UUID()
        newExamInfo.text = text
        newExamInfo.examPeriod = examPeriod
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
        case .school:
            schools = try? container.viewContext.fetch(School.fetchRequest())
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
    
    // MARK: Get
    func getMembers(classInfo: ClassInfo) -> [Members] {
        let request = Members.fetchRequest()
        let filter = NSPredicate(format: "classInfo == %@", classInfo)
        request.predicate = filter
        var filterMembers:[Members] = []
        do {
            filterMembers = try container.viewContext.fetch(request)
        } catch let error {
            print("Fetch Error, get Members, \(error)")
        }
        return filterMembers
    }
    
    func getSchedules(classInfo: ClassInfo) -> [Schedule] {
        let request = Schedule.fetchRequest()
        let filter = NSPredicate(format: "classInfo == %@", classInfo)
        request.predicate = filter
        var filterSchedules:[Schedule] = []
        do {
            filterSchedules = try container.viewContext.fetch(request)
            filterSchedules = filterSchedules.filter{ $0.endTime ?? Date() <= Date()}
        } catch let error {
            print("Fetch Error, get Members, \(error)")
        }
        return filterSchedules
    }
    
    // MARK: Fetch
    func fetchSchedules(section: Section) -> [Schedule] {
        let request = Schedule.fetchRequest()
        let filter = NSPredicate(format: section == .next ? "endTime > %@" : "endTime < %@" , Date() as NSDate)
        var sort = NSSortDescriptor(keyPath: \Schedule.startTime, ascending: true)
        if section == .prev {
            sort = NSSortDescriptor(keyPath: \Schedule.endTime, ascending: false)
        }
        request.predicate = filter
        request.sortDescriptors = [sort]
        var filterSchedules:[Schedule]? = []
        filterSchedules = try? container.viewContext.fetch(request)
        
        if let filterSchedules = filterSchedules {
            return filterSchedules
        } else {
            return []
        }
    }
    
    func fetchExamPeriods(school: School) -> [ExamPeriod] {
        let request = ExamPeriod.fetchRequest()
        let filter = NSPredicate(format: "school == %@", school)
        let sort = NSSortDescriptor(keyPath: \ExamPeriod.startDate, ascending: true)
        request.predicate = filter
        request.sortDescriptors = [sort]
        let examPeriods = try? container.viewContext.fetch(request)
        
        if let examPeriods = examPeriods {
            return examPeriods
        } else {
            return []
        }
    }

}

// MARK: DataModel
enum DataModel {
    case classInfo
    case schedule
    case members
    case classIteration
    case school
}

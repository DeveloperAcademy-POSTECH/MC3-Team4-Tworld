//
//  PlanViewModel.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/29.
//

import Foundation

class PlanViewModel: ObservableObject {
    
    let manager = DataManager.shared
    
    @Published var selectedDate = Date().toDay
    @Published var schedule: [Schedule] = []
    @Published var examPeriods: [Int:[ExamInfo]] = [:]
    @Published var schedules: [Date:[Schedule]] = [:]
    
    func fetchPlan() {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: selectedDate) else { return }
        let dates = Calendar.current.generateDates(inside: monthInterval, matching: DateComponents(hour: 0, minute: 0, second: 0))
        for date in dates {
            let request = Schedule.fetchRequest()
            let filter = NSPredicate(format: "startTime > %@ AND endTime < %@", date as NSDate, date.nextDay() as NSDate)
            let sort = NSSortDescriptor(keyPath: \Schedule.startTime, ascending: true)
            request.predicate = filter
            request.sortDescriptors = [sort]
            do {
                let result = try manager.container.viewContext.fetch(request)
                schedules[date] = result
            } catch {
                print(error)
            }
        }
    }
    
//    func fetchSchedule() {
//        let request = Schedule.fetchRequest()
//        let filter = NSPredicate(format: "startTime = %@", selectedDate as NSDate)
//        let sort = NSSortDescriptor(keyPath: \Schedule.startTime, ascending: true)
//        request.predicate = filter
//        request.sortDescriptors = [sort]
//        do {
//            let result = try manager.container.viewContext.fetch(request)
//            schedule = result
//        } catch {
//            print(error)
//        }
//    }
    
//    func fetchExamPeriod() {
//        let request = ExamPeriod.fetchRequest()
//        do {
//            let results = try manager.container.viewContext.fetch(request)
//            examPeriods = [:]
//            for result in results {
//                guard let infos = result.examInfos?.allObjects as? [ExamInfo] else { return }
//                examPeriods[result] = infos
//            }
//        } catch {
//            print(error)
//        }
//    }
}

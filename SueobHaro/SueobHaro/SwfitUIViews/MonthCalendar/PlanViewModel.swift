//
//  PlanViewModel.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/29.
//

import Foundation

class PlanViewModel: ObservableObject {
    
    let manager = DataManager.shared
    
    @Published var selectedDate = Date()
    @Published var schedule: [Schedule] = []
    @Published var examInfos: [ExamInfo] = []
    
    func fetchSchedule() {
        let request = Schedule.fetchRequest()
        let filter = NSPredicate(format: "startTime = %@", selectedDate as NSDate)
        let sort = NSSortDescriptor(keyPath: \Schedule.startTime, ascending: true)
        request.predicate = filter
        request.sortDescriptors = [sort]
        do {
            let result = try manager.container.viewContext.fetch(request)
            schedule = result
        } catch {
            print(error)
        }
    }
    
    func fetchExamPeriod() {
        let request = ExamPeriod.fetchRequest()
//        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: date) else { return }
        do {
            let results = try manager.container.viewContext.fetch(request)
            examInfos = []
            for result in results {
                guard let infos = result.examInfos?.allObjects as? [ExamInfo] else { return }
                examInfos.append(contentsOf: infos)
            }
            print(examInfos.map{ $0.date?.description(with: .current) })
        } catch {
            print(error)
        }
    }
}

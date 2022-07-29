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
    
    func fetchSchedule(date: Date) {
        let request = Schedule.fetchRequest()
        let filter = NSPredicate(format: "startTime = %@", date as NSDate)
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
}

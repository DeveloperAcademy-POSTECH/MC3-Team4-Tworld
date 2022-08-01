//
//  CalendarUtil.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/28.
//

import Foundation

extension Calendar {
    
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! + 1 // <1>
    }
}

extension Date {
    
    var toDay: Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self) ?? self
    }
    
    var hour: Int {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour
    }
    
    var minute: Int {
        let minute = Calendar.current.component(.hour, from: Date())
        return hour
    }
    
    func nextDay() -> Date {
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: .day, value: 1, to: self) ?? self
        return newDate
    }
    
    func isSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}

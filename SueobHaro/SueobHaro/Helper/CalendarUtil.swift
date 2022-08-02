//
//  CalendarUtil.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/28.
//

import Foundation

extension Calendar {
    
    func generateDatesAfter(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        
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

extension String {
    func toWeekOfDayNum() -> Int {
        switch self {
        case "월":
            return 2
        case "화":
            return 3
        case "수":
            return 4
        case "목":
            return 5
        case "금":
            return 6
        case "토":
            return 7
        case "일":
            return 1
        default:
            return 2
        }
    }
}

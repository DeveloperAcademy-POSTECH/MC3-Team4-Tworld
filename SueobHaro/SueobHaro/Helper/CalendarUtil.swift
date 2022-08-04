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
    
    func generateWeekOfDays(
        inside interval: DateInterval,
        matching days: [String],
        start startTime: [Date],
        end endTime: [Date]
    ) -> [DateInterval] {
        var dateIntervals: [DateInterval] = []
        
        var days = days.map{ $0.toWeekOfDayNum() }
        
        typealias Plan = (day: Int, start: Date, end: Date)
        var plans: [Plan] = []
        
        for i in 0..<days.count {
            plans.append(Plan(day: days[i], start: startTime[i], end: endTime[i]))
        }
        
        plans.sort { $0.day < $1.day }
        
        days = plans.map{ $0.day }
        var startTime = plans.map{ $0.start }
        var endTime = plans.map{ $0.end }
        
        while days[0] < interval.start.weekOfDay {
            days.append(days.remove(at: 0))
            startTime.append(startTime.remove(at: 0))
            endTime.append(endTime.remove(at: 0))
        }
        
        var daysInterval: [Int] = [0]

        for i in 0..<days.count {
            if i == 0 { continue }
            if days[i] > days[0] {
                daysInterval.append(days[i] - days[0])
            } else {
                daysInterval.append(days[i] - days[0] + 7)
            }
        }

        let components = DateComponents(weekday: days[0])
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    for (i, interval) in daysInterval.enumerated() {
                        var startDate = Calendar.current.date(byAdding: .day, value: interval, to: date)!
                        startDate = Calendar.current.date(byAdding: .hour, value: startTime[i].hour, to: startDate)!
                        startDate = Calendar.current.date(byAdding: .minute, value: startTime[i].minute, to: startDate)!
                        
                        var endDate = Calendar.current.date(byAdding: .day, value: interval, to: date)!
                        endDate = Calendar.current.date(byAdding: .hour, value: endTime[i].hour, to: endDate)!
                        endDate = Calendar.current.date(byAdding: .minute, value: endTime[i].minute, to: endDate)!
                        
                        dateIntervals.append(DateInterval(start: startDate, end: endDate))
                    }
                } else {
                    stop = true
                }
            }
        }
        print(dateIntervals)
        return dateIntervals
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
    
    var weekOfDay: Int {
        let weekOfDay = Calendar.current.component(.weekday, from: self)
        return weekOfDay
    }
    
    var hour: Int {
        let hour = Calendar.current.component(.hour, from: self)
        return hour
    }
    
    var minute: Int {
        let minute = Calendar.current.component(.minute, from: self)
        return minute
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

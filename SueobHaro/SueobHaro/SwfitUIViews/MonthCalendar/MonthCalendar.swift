//Orginal code from: https://gist.github.com/mecid/f8859ea4bdbd02cf5d440d58e936faec
//I just made some modification in appearnce, show monthly navigator and weekdays.

import SwiftUI

struct ContentView: View {
    
    @Environment(\.calendar) var calendar
    
    var body: some View {
        VStack{
            CalendarView { date in
                VStack {
                    Text(String(self.calendar.component(.day, from: date)))
                        .foregroundColor(Color.white)
                    
                    VStack {
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8, height: 8)
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8, height: 8)
                        }
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8, height: 8)
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "ko"))
    }
}




fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

fileprivate extension Calendar {
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
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let week: Date
    let content: (Date) -> DateView
    
    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }
    
    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
        else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    @State private var now: Date
    let content: (Date) -> DateView
    
    init(
        now: Date = Date(),
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self._now = State(initialValue: now)
        self.content = content
    }
    
    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: now)
        else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }
    
    func changeDateBy(_ months: Int) {
        if let date = Calendar.current.date(byAdding: .month, value: months, to: now) {
            self.now = date
        }
    }
    
    private var header: some View {
        let component = calendar.component(.month, from: now)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        formatter.dateFormat = "L"
        return HStack{
            Text(now, format: .dateTime)
                .padding(.leading)
            Spacer()
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            header
            HStack{
                ForEach(0..<7, id: \.self) {index in
                    Text(getWeekDaysSorted()[index])
                        .frame(maxWidth: .infinity)
                }
            }
            
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
    
    func getWeekDaysSorted() -> [String]{
        ["일","월","화","수","목","금","토"]
    }
}


import SwiftUI

enum Quadrant: String, CaseIterable {
    case first
    case second
    case third
    case fourth
    
    var area: CGPoint {
        switch self {
        case .first:
            return .init(x: 1, y: 1)
        case .second:
            return .init(x: -1, y: 1)
        case .third:
            return .init(x: -1, y: -1)
        case .fourth:
            return .init(x: 1, y: -1)
        }
    }
}

struct MonthCalendarView: View {
    
    @Environment(\.calendar) var calendar
    @State private var standardDate = Date()
    @State private var selectedDate = Date()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                header
                    .padding(.bottom, 2)
                    .padding(.horizontal, 16)
                    .background(Color.spBlack)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(Color.greyscale5)
                            .frame(height: 1)
                    }
                
                MonthView(now: $standardDate) { date in
                    ZStack(alignment: .top) {
                        Button {
                            selectedDate = date
                        } label: {
                            cell(date: date)
                        }
                        .buttonStyle(.plain)
                        
                        todayIndicator(date: date)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
                .background(.black)
                
                Spacer()
                    .frame(height: .padding.toDifferentHierarchy)
                
                plan(date: selectedDate)
                    .padding(.bottom, .padding.toDifferentHierarchy)
            }
        }
    }
    
    private func plan(date: Date) -> some View {
        let month = calendar.component(.month, from: selectedDate)
        let day = calendar.component(.day, from: selectedDate)
        
        return VStack(spacing: 20) {
            Text("\(month)월 \(day)일 일정")
                .font(Font(uiFont: .systemFont(for: .title2)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
            VStack(spacing: .padding.toComponents) {
                ForEach(0..<3) { i in
                    ScheduleInfoView()
                }
            }
        }
    }
    
    private func todayIndicator(date: Date) -> some View {
        Circle()
            .fill(Color.spLightBlue)
            .frame(width: 6, height: 6)
            .offset(y: -8)
            .opacity(Calendar.current.isDate(Date(), inSameDayAs: date) ? 1 : 0)
    }
    
    private func cell(date: Date) -> some View {
        return VStack(spacing: 0) {
            Text(String(calendar.component(.day, from: date)))
                .font(Font(uiFont: .systemFont(for: .body1)))
                .foregroundColor(
                    Calendar.current.isDate(selectedDate, inSameDayAs: date) ? .greyscale7 : .greyscale1
                )
                .padding(.vertical, 2)
                .frame(width: 32)
                .background(
                    ZStack {
                        if Calendar.current.isDate(selectedDate, inSameDayAs: date) {
                            Capsule()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color.spLightGradientLeft, Color.spLightGradientRight]), startPoint: .topTrailing, endPoint: .bottomLeading)
                                )
                        } else {
                            EmptyView()
                        }
                    }
                )
                .foregroundColor(.greyscale1)
            ZStack {
                ForEach(Quadrant.allCases, id: \.rawValue) { q in
                    Circle()
                        .fill()
                        .frame(width: 8, height: 8)
                        .offset(x: q.area.x * 6.5, y: q.area.y * 6.5)
                }
            }
            .frame(width: 6.5+6.5+4+4, height: 6.5+6.5+4+4)
            .padding(.vertical, .padding.toText)
        }
        .frame(maxWidth: .infinity)

    }
    
    private var header: some View {
        let month = calendar.component(.month, from: standardDate)
        let year = calendar.component(.year, from: standardDate)

        func getWeekDaysSorted() -> [String]{
            ["일","월","화","수","목","금","토"]
        }
        
        return VStack(spacing: 20) {
            HStack{
                Text("\(String(year))년 \(month)월")
                    .font(Font(uiFont: .systemFont(for: .title2)))
                Spacer()
            }
            
            HStack{
                ForEach(0..<7, id: \.self) {index in
                    Text(getWeekDaysSorted()[index])
                        .font(Font(uiFont: .systemFont(for: .caption)))
                        .foregroundColor(.greyscale3)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView()
            .preferredColorScheme(.dark)
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

struct MonthView<DateView>: View where DateView: View {
    
    @Environment(\.calendar) var calendar
    @Binding var now: Date
    let content: (Date) -> DateView
    
    init(now: Binding<Date>, @ViewBuilder content: @escaping (Date) -> DateView) {
        self._now = now
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
            
    var body: some View {
        VStack(spacing: 20) {
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}

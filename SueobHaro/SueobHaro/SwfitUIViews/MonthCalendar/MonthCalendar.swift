
import SwiftUI

struct MonthCalendarView: View {
    
    @Environment(\.calendar) var calendar
    @State private var standardDate = Date()
    @ObservedObject var vm: PlanViewModel
    
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
                
                YearView(now: $standardDate) { date in
                    ZStack(alignment: .top) {
                        Button {
                            withAnimation(.spring()) {
                                vm.selectedDate = date
                                print(vm.examInfos)
                            }
                        } label: {
                            cell(date: date)
                        }
                        .buttonStyle(.plain)
                        
                        todayIndicator(date: date)
                    }
                }
                .frame(height: 400)
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
                .background(.black)
                
                Spacer()
                    .frame(height: .padding.toDifferentHierarchy)
                
                plan(date: vm.selectedDate)
                    .padding(.bottom, .padding.toDifferentHierarchy)
            }
        }
        .onAppear{
            vm.fetchPlan()
            vm.fetchExamPeriod()
        }
        .onChange(of: standardDate) { newValue in
            vm.selectedDate = standardDate
            vm.fetchPlan()
            vm.fetchExamPeriod()
        }
    }
    
    private func plan(date: Date) -> some View {
        let year = String(calendar.component(.year, from: vm.selectedDate))
        let month = calendar.component(.month, from: vm.selectedDate)
        let day = calendar.component(.day, from: vm.selectedDate)
        
        return VStack(spacing: 20) {
            Text("\(year)년 \(month)월 \(day)일 일정")
                .font(Font(uiFont: .systemFont(for: .title2)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
            VStack(spacing: .padding.toComponents) {
                ForEach(vm.schedules[vm.selectedDate] ?? []) { schedule in
                    ScheduleInfoView(schedule: schedule)
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
                    Calendar.current.isDate(vm.selectedDate, inSameDayAs: date) ? .greyscale7 : .greyscale1
                )
                .padding(.vertical, 2)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        if Calendar.current.isDate(vm.selectedDate, inSameDayAs: date) {
                            Capsule()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color.spLightGradientLeft, Color.spLightGradientRight]), startPoint: .topTrailing, endPoint: .bottomLeading)
                                )
                                .padding(.horizontal, 8)
                        } else {
                            EmptyView()
                        }
                        
                        ForEach(vm.examInfos[date] ?? []) { info in
                            Rectangle()
                                .fill(Color.spLightBlue.opacity(0.3))
                        }
                    }
                )
                .foregroundColor(.greyscale1)
            ZStack {
                if let schedules = vm.schedules[date] {
                    ForEach(Array(schedules.enumerated()), id: \.offset) { i, schedule in
                        Circle()
                            .fill(Color(schedule.classInfo?.color ?? ""))
                            .frame(width: 8, height: 8)
                            .offset(x: calIndicatorOffset(i).x * 6.5,
                                    y: calIndicatorOffset(i).y * 6.5)
                    }
                }
            }
            .frame(width: 6.5+6.5+4+4, height: 6.5+6.5+4+4)
            .padding(.vertical, .padding.toText)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())

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
    
    private func calIndicatorOffset(_ index: Int) -> CGPoint {
        switch index {
        case 0:
            return .init(x: -1, y: -1)
        case 1:
            return .init(x: 1, y: -1)
        case 2:
            return .init(x: -1, y: 1)
        default:
            return .init(x: 1, y: 1)
        }
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
        HStack(spacing: 0) {
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
    let month: Date
    let content: (Date) -> DateView
    
    init(month: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.month = month
        self.content = content
    }
    
    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month)
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

struct YearView<DateView>: View where DateView: View {
    
    @Environment(\.calendar) var calendar
    @Binding var now: Date
    let content: (Date) -> DateView
    
    init(now: Binding<Date>, @ViewBuilder content: @escaping (Date) -> DateView) {
        self._now = now
        self.content = content
    }
    
    private var months: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .year, for: now)
        else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        TabView {
            ForEach(months, id: \.self) { month in
                MonthView(month: month, content: self.content)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

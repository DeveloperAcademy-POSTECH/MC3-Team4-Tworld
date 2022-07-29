//
//  PlanView.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/29.
//

import SwiftUI

enum CalendarCase: String {
    case month
    case week
}

struct PlanView: View {
    
    @State private var calendarCase: CalendarCase = .month
    @State private var selectedDate = Date()
    
    var body: some View {
        ZStack {
            
            Color.spBlack.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HStack {
                    calendarCasePicker
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 12)
                
                if calendarCase == .week {
                    Spacer()
                } else {
                    MonthCalendarView(selectedDate: $selectedDate)
                }
            }
        }
    }
    
    private var calendarCasePicker: some View {
        HStack(spacing: 0) {
            Text("주간일정")
                .padding(4)
                .onTapGesture {
                    withAnimation(.spring()) {
                        calendarCase = .week
                    }
                }
            Text("월간일정")
                .padding(4)
                .onTapGesture {
                    withAnimation(.spring()) {
                        calendarCase = .month
                    }
                }
        }
        .padding(.bottom, 3)
        .font(Font(uiFont: .systemFont(for: .title3)))
        .overlay(alignment: .bottom) {
            GeometryReader { geo in
                Rectangle()
                    .fill(Color.greyscale1)
                    .padding(.horizontal, 4)
                    .frame(width: geo.size.width / 2)
                    .frame(maxWidth: .infinity, alignment: calendarCase == .week ? .leading : .trailing)
            }
            .frame(height: 3)
        }
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}

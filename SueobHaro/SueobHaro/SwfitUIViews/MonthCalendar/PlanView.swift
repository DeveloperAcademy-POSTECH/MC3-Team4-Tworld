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
    @StateObject private var vm = PlanViewModel()
    @State private var calendarCase: CalendarCase  = {
        @AppStorage("monthCalendarFirst") var monthCalendarFirst: Bool = false
        return monthCalendarFirst ? .month : .week
    }()
    @State private var showClassAddView = false
    @State private var showExamAddView = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                NavigationLink(isActive: $showExamAddView,
                               destination: {ClassExamAddView(){fetch()}},
                               label: {EmptyView()})
                
                NavigationLink(isActive: $showClassAddView,
                               destination: {
                    ClassAddView(dismissAction: {
                        showClassAddView = false
                        fetch()
                    })
                },
                label: {EmptyView()})
                
                Color.spBlack.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    HStack {
                        calendarCasePicker
                            
                        Spacer()
                        
                        Menu {
                            Button {
                                showClassAddView = true
                            } label: {
                                Label("수업 추가", systemImage: "book")
                            }
                            
                            Button {
                                showExamAddView = true
                            } label: {
                                Label("시험기간 추가", systemImage: "pencil.and.outline")
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text("추가하기")
                                    .font(Font(uiFont: .systemFont(for: .body1)))
                                Image(systemName: "plus")
                            }
                            .foregroundColor(.spLightBlue)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    
                    if calendarCase == .week {
                        WeeklyCalendarView()
                            .frame(width: UIScreen.main.bounds.width)
                    } else {
                        MonthCalendarView(vm: vm)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var calendarCasePicker: some View {
        HStack(spacing: 0) {
            Text("주간일정")
                .foregroundColor(.white)
                .padding(4)
                .onTapGesture {
                    withAnimation(.spring()) {
                        calendarCase = .week
                    }
                }
            Text("월간일정")
                .foregroundColor(.white)
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
    
    private func fetch() {
        showExamAddView = false
        vm.fetchPlan()
    }
}


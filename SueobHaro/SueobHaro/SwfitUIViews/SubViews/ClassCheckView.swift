//
//  ClassCheckView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/20.
//

import SwiftUI

struct ClassCheckView: View {
    @Binding var className: String
    @Binding var firstClassDate: Date
    @Binding var isDayPicked: [String:Bool]
    @Binding var classTimeInfo: [String:[String:Date?]]
    @Binding var memberNames: [String]
    @Binding var memberSchools: [String]
    @Binding var memberPhoneNumbers: [String]
    @Binding var tuition: String
    @Binding var tuitionPer: String
    
    @State private var isNavHidden = true
    @State var classDay: [String] = []
    
    var dismissAction: (() -> Void)
    
    // color 랜덤 수정해야함
    private func save() {
        var startTimes: [Date] = []
        var endTimes: [Date] = []
        for day in classDay {
            startTimes.append(classTimeInfo[day]!["start"]!!)
            endTimes.append(classTimeInfo[day]!["end"]!!)
        }
        DispatchQueue.main.async {
            DataManager.shared.addClassInfo(firstDate: firstClassDate, tuition: Int32(tuition)!, tuitionPer: Int16(tuitionPer)!, name: className, color: nil, location: nil, day: classDay, startTime: startTimes, endTime: endTimes, memberName: memberNames, memberPhoneNumber: memberPhoneNumbers, memberSchool: memberSchools)
        }
    }
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                        Image("addDone")
                            .padding(.top, CGFloat.padding.toTextComponents)
                        Spacer()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.spTurkeyBlue, lineWidth: 1)
                            .background(Color.spBlack)
                        HStack(spacing: 0) {
                            Spacer()
                            VStack(spacing: CGFloat.padding.toText) {
                                Text("\(className)")
                                    .font(Font(uiFont: .systemFont(for: .title2)))
                                    .foregroundColor(Color.greyscale1)
                                Text(memberNames.joined(separator: ", "))
                                    .font(Font(uiFont: .systemFont(for: .body1)))
                                    .foregroundColor(Color.greyscale3)
                                Divider()
                                    .foregroundColor(Color.greyscale4)
                                Text("\(tuitionPer)회마다 총 \(tuition)원 받아요.")
                                    .font(Font(uiFont: .systemFont(for: .title3)))
                                    .foregroundColor(Color(UIColor.theme.greyscale1))
                                    .padding(.vertical, CGFloat.padding.inBox - CGFloat.padding.toText)
                            }
                            Spacer()
                        }.padding(.vertical, CGFloat.padding.inBox)
                    }.padding(.top, CGFloat.padding.toTextComponents)
                    Text("수업 일정")
                        .font(Font(uiFont: .systemFont(for: .title3)))
                        .foregroundColor(Color.greyscale1)
                        .padding(.top, CGFloat.padding.toDifferentHierarchy)
                        .padding(.bottom, CGFloat.padding.toTextComponents)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.greyscale6, lineWidth: 1)
                            .background(Color.spBlack)
                        VStack(spacing: CGFloat.padding.inBox) {
                            ForEach(classDay, id: \.self) { day in
                                if isDayPicked[day]! {
                                    ClassInformationListComponent(firstText: day, secondText: "\(DateFormatUtil.classTimeFormatter(time: classTimeInfo[day]!["start"]!!)) ~ \(DateFormatUtil.classTimeFormatter(time: classTimeInfo[day]!["end"]!!))")
                                    if day != classDay.last {
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(Color.greyscale6)
                                    }
                                }
                            }
                        }.padding(.vertical, CGFloat.padding.inBox)
                    }
                    Text("연락처")
                        .font(Font(uiFont: .systemFont(for: .title3)))
                        .foregroundColor(Color.greyscale1)
                        .padding(.top, CGFloat.padding.toDifferentHierarchy)
                        .padding(.bottom, CGFloat.padding.toTextComponents)
                    ZStack {
                        VStack(spacing: CGFloat.padding.inBox) {
                            ForEach(memberNames.indices, id: \.self) { idx in
                                ClassMemberGridView(memberNames: memberNames, memberSchools: memberSchools, memberPhoneNumbers: memberPhoneNumbers)
                            }
                        }
                    }
                    HStack(spacing: 0) {
                        Spacer()
                        Text("수업 등록이 완료됐어요!")
                            .font(Font(uiFont: .systemFont(for: .title3)))
                            .foregroundColor(Color.greyscale1)
                            .padding(.vertical, CGFloat.padding.toDifferentHierarchy)
                        Spacer()
                    }
                    Button(action: {
                        save()
                        dismissAction()
                        isNavHidden = false
                    }, label: {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.spLightBlue, Color.spDarkBlue]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                            Text("확인")
                                .font(Font(uiFont: .systemFont(for: .button)))
                                .foregroundColor(.greyscale1)
                        }
                        .frame(height: 52)
                    })
                    .padding(.bottom, CGFloat.padding.toComponents)
                }
            }
            .padding(.horizontal, CGFloat.padding.margin)
        }
        .onAppear {
            classDay = isDayPicked.allKeys(forValue: true)
        }
        .navigationBarBackButtonHidden(isNavHidden)
    }
}

extension Dictionary where Value: Equatable {
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}

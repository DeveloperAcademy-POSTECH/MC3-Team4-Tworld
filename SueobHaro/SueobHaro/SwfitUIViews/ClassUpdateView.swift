//
//  ClassUpdateView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/29.
//

import SwiftUI
import Combine

struct ClassUpdateView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var classInfo: ClassInfo?

    @State var navBarHidden: Bool = true
    @State var className: String = ""
    @State var firstClassDate = Date()
    @State var isDayPicked: [String:Bool] = ["월":false, "화":false, "수":false, "목":false, "금":false, "토":false, "일":false]
    @State var classTimeInfo: [String:[String:Date?]] = ["월":["start":nil, "end":nil],
                                                         "화":["start":nil, "end":nil],
                                                         "수":["start":nil, "end":nil],
                                                         "목":["start":nil, "end":nil],
                                                         "금":["start":nil, "end":nil],
                                                         "토":["start":nil, "end":nil],
                                                         "일":["start":nil, "end":nil]]
    @State var halfModal: Bool = false
    @State var selectedDay: String? = nil
    @State var firsthalfModal: Bool = true
    @State var startTime = Date()
    @State var endTime = Date()
    
    @State var memberNames: [String] = []
    @State var memberSchools: [String] = []
    @State var memberPhoneNumbers: [String] = []
    @State var tuition: String = ""
    @State var tuitionPer: String = ""
    @State var tuitionPageDone: Bool = false
    
    @FocusState private var isFocused: Bool
    @FocusState private var isTuitionFocused: Bool
    @FocusState private var isTuitionPerFocused: Bool
    @FocusState private var isNameFocused: Bool
    @FocusState private var isScoolFocused: Bool
    @FocusState private var isPhoneNumberFocused: Bool
    
    let dayList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    let dateFormatter = DateFormatter()
    @State var currentIdx: Int? = nil
    
    
    var body: some View {
        
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: CGFloat.padding.toComponents) {
                    HStack(spacing: 0) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            NavBarBackButton(title: classInfo?.name ?? "")
                        })
                        .padding([.top, .leading], 8)
                        Spacer()
                        Button(action: {
                            save()
                        }, label: {
                            Text("저장")
                                .font(.body)
                                .foregroundColor(.spLightBlue)
                        })
                        .padding([.top, .trailing], 8)
                    }
                }
                ScrollView(showsIndicators:false) {
                    HStack{
                        Text("수업명")
                            .font(Font(uiFont: .systemFont(for: .title3)))
                            .foregroundColor(Color.greyscale1)
                        Spacer()
                    }
                    .padding(.top, CGFloat.padding.toTextComponents)
                    .padding(.bottom, CGFloat.padding.toTextComponents)
                    .padding(.horizontal, CGFloat.padding.margin)
                    
                    
                    
                    ClassTextField(content: $className, isFocused: $isFocused, placeholder: "수업명을 입력하세요.")
                        .padding(.bottom, CGFloat.padding.toDifferentHierarchy)
                        
                    
                    
                    HStack(spacing: 0) {
                        DatePickerView(date: $firstClassDate)
                        Text("부터 수업을 진행해요.")
                            .font(Font(uiFont: .systemFont(for: .body2)))
                            .foregroundColor(.greyscale1)
                        Spacer()
                    }
                    .padding(.horizontal, CGFloat.padding.margin)
                    
                    HStack {
                        Text("수업료는 몇 회차마다 받나요?")
                            .font(Font(uiFont: .systemFont(for: .title3)))
                            .foregroundColor(.greyscale1)
                        Spacer()
                    }
                    
                        .padding(.top, CGFloat.padding.toDifferentHierarchy)
                        .padding(.leading, CGFloat.padding.margin)
                        .padding(.bottom, CGFloat.padding.toText)
                    ClassTextField(content: $tuitionPer, isFocused: $isTuitionPerFocused, placeholder: "회차를 입력하세요.", keyboardType: .numberPad)
                    
                    HStack {
                        Text("수업료는 얼마씩 받나요?")
                            .font(Font(uiFont: .systemFont(for: .title3)))
                            .foregroundColor(.greyscale1)
                        Spacer()
                    }
                    
                        .padding(.top, CGFloat.padding.toDifferentHierarchy)
                        .padding(.leading, CGFloat.padding.margin)
                        .padding(.bottom, CGFloat.padding.toText)
                    ClassTextField(content: $tuition, isFocused: $isTuitionFocused, placeholder: "수업료를 입력하세요.", keyboardType: .numberPad)
                    
                    HStack {
                        Text("수업 일정")
                            .font(Font(uiFont: .systemFont(for: .title3)))
                            .foregroundColor(.greyscale1)
                        Spacer()
                    }
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                    .padding(.bottom, CGFloat.padding.toText)
                        
                    Group {
                        HStack(spacing: CGFloat.padding.toText) {
                            ForEach(dayList, id: \.self) { day in
                                ZStack(alignment: .center) {
                                    Circle()
                                        .stroke(isDayPicked[day]! ? Color.spLightBlue : Color.greyscale3, lineWidth: 1)
                                        
                                        
                                    Text(day)
                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                        .frame(alignment: .leading)
                                        .foregroundColor(isDayPicked[day]! ? Color.spLightBlue : Color.greyscale3)
                                }.onTapGesture {
                                    selectedDay = day
                                    if isDayPicked[day]! {
                                        isDayPicked[day] = false
                                        print(classTimeInfo)
                                    } else {
                                        withAnimation(.spring()){
                                            isDayPicked[day] = true
                                            halfModal.toggle()
                                        }
                                    }
                                }
                                
                            }
                        }
                        .padding(.horizontal, CGFloat.padding.margin)
                        .frame(height: 45)
                        
                    
                        LazyVStack(spacing: CGFloat.padding.toComponents) {
                            ForEach(dayList, id: \.self) { day in
                                if isDayPicked[day]! {
                                    ZStack {
                                        HStack(spacing: CGFloat.padding.inBox) {
                                            Text(day)
                                                .font(Font(uiFont: .systemFont(for: .title3)))
                                                .foregroundColor(.greyscale1)
                                            Group {
                                                if classTimeInfo[day]!["start"]! != nil && classTimeInfo[day]!["end"]! != nil {
                                                    Text("\(dateFormatter.string(from: classTimeInfo[day]!["start"]!!)) ~ \(dateFormatter.string(from: classTimeInfo[day]!["end"]!!))")
                                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                                        .foregroundColor(.greyscale1)
                                                } else {
                                                    Text("시간을 입력해주세요")
                                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                                        .foregroundColor(.greyscale3)
                                                }
                                            }.onTapGesture {
                                                selectedDay = day
                                                
                                                withAnimation(.spring()){
                                                    halfModal.toggle()
                                                }
                                                
                                            }
                                            Spacer()
                                            Text("1주마다")
                                                .font(Font(uiFont: .systemFont(for: .body2)))
                                                .foregroundColor(.greyscale1)
                                        }
                                        .padding(CGFloat.padding.inBox)
                                        .background(
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.greyscale7)
                                                RoundedRectangle(cornerRadius: 10)
                                                    .strokeBorder(((classTimeInfo[day]!["start"]! != nil && classTimeInfo[day]!["end"]! != nil) ? Color.greyscale1 : Color.greyscale4), lineWidth: 1)
                                            }
                                        )
                                    }
                                }
                            }
                        }
                        .padding(.top, CGFloat.padding.toComponents)
                        .padding(.horizontal, CGFloat.padding.margin)
                        
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("참여자")
                            .font(Font(uiFont: .systemFont(for: .title3)))
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.margin)
                            .padding(.top, CGFloat.padding.toDifferentHierarchy)
                        ScrollView {
                            LazyVStack(spacing: CGFloat.padding.toComponents) {
                                ForEach(memberNames.indices, id: \.self) { idx in
                                    ZStack {
                                        VStack(spacing: 0) {
                                            HStack(spacing: 0) {
                                                TextField("", text: $memberNames[idx])
                                                    .placeholder(when: memberNames[idx].isEmpty) {
                                                        Text("이름")
                                                            .foregroundColor(.greyscale4)
                                                            .font(Font(uiFont: .systemFont(for: .title3)))
                                                    }
                                                    .focused($isNameFocused)
                                                    .font(Font(uiFont: .systemFont(for: .title3)))
                                                    .foregroundColor(.greyscale1)
                                                    .onReceive(Just(memberNames[idx]), perform: { _ in
                                                        if 3 < memberNames[idx].count {
                                                            memberNames[idx] = String(memberNames[idx].prefix(3))
                                                        }
                                                    })
                                                Spacer()
                                                Image(systemName: "trash")
                                                    .foregroundColor(.white)
                                                    .font(Font(uiFont: .systemFont(for: .body2)))
                                                    .onTapGesture {
                                                        memberNames.remove(at: idx)
                                                        memberSchools.remove(at: idx)
                                                        memberPhoneNumbers.remove(at: idx)
                                                    }
                                            }
                                            .padding(.bottom, .padding.toTextComponents)
                                            TextField("", text: $memberSchools[idx])
                                                .placeholder(when: memberSchools[idx].isEmpty) {
                                                    Text("학교를 입력해주세요. (선택)")
                                                        .foregroundColor(.greyscale4)
                                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                                }
                                                .focused($isScoolFocused)
                                                .font(Font(uiFont: .systemFont(for: .body2)))
                                                .foregroundColor(.greyscale1)
                                                .onReceive(Just(memberSchools[idx]), perform: { _ in
                                                    if 11 < memberSchools[idx].count {
                                                        memberSchools[idx] = String(memberSchools[idx].prefix(11))
                                                    }
                                                })
                                                .padding(.bottom, .padding.toText)
                                            TextField("", text: $memberPhoneNumbers[idx])
                                                .placeholder(when: memberPhoneNumbers[idx].isEmpty) {
                                                    Text("번호를 입력해주세요. (선택)")
                                                        .foregroundColor(.greyscale4)
                                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                                }
                                                .focused($isPhoneNumberFocused)
                                                .font(Font(uiFont: .systemFont(for: .body2)))
                                                .foregroundColor(.greyscale1)
                                                .keyboardType(.numberPad)
                                                .onReceive(Just(memberPhoneNumbers[idx]), perform: { _ in
                                                    if 11 < memberPhoneNumbers[idx].count {
                                                        memberPhoneNumbers[idx] = String(memberPhoneNumbers[idx].prefix(11))
                                                    }
                                                })
                                        }
                                        .padding(CGFloat.padding.inBox)
                                        .background(
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.greyscale7)
                                                RoundedRectangle(cornerRadius: 10)
                                                    .strokeBorder(currentIdx == idx ? Color.spLightBlue : ((memberNames[idx].isEmpty || memberPhoneNumbers[idx].isEmpty || memberSchools[idx].isEmpty) ? Color.greyscale5 : Color.greyscale1), lineWidth: 1)
                                            }
                                        )
                                    }
                                    .onTapGesture{
                                        currentIdx = idx
                                    }
                                }
                                Button(action: {
                                    memberNames.append("")
                                    memberSchools.append("")
                                    memberPhoneNumbers.append("")
                                }, label: {
                                    ZStack {
                                        HStack(spacing: 0) {
                                            Text("+ 새로운 참여자 추가하기")
                                                .font(Font(uiFont: .systemFont(for: .body1)))
                                                .foregroundColor(.spLightBlue)
                                            Spacer()
                                        }
                                        .padding(CGFloat.padding.inBox)
                                        .background(
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.greyscale7)
                                                RoundedRectangle(cornerRadius: 10)
                                                    .strokeBorder(Color.greyscale5, lineWidth: 1)
                                            }
                                        )
                                    }
                                })
                            }
                        }
                        .padding(.top, CGFloat.padding.toTextComponents)
                        .padding(.horizontal, CGFloat.padding.margin)
                        
                    }
                }
            }
            
            
        }
        .navigationBarHidden(true)
        .onTapGesture {
            isFocused = false
            if isTuitionFocused {
                isTuitionFocused = false
            }
            if isTuitionPerFocused {
                isTuitionPerFocused = false
            }
            isNameFocused = false
            isScoolFocused = false
            isPhoneNumberFocused = false
            currentIdx = nil
        }
        .onAppear {
            dateFormatter.dateFormat = "HH:mm"
            
            if let info = classInfo {
                className = info.name ?? ""
                firstClassDate = info.firstDate ?? Date()
                for i in info.classIterArray {
                    isDayPicked[i.day!] = true
                    classTimeInfo[i.day!]!["start"] = i.startTime ?? Date()
                    classTimeInfo[i.day!]!["end"] = i.endTime ?? Date()
                }
                
                for i in info.membersArray {
                    memberNames.append(i.name!)
                    memberSchools.append("태양고")
//                    memberSchools.append(i.school!)
                    memberPhoneNumbers.append(i.phoneNumber!)
                }
                tuition = String(info.tuition)
                tuitionPer = String(info.tuitionPer)
            }
            UITabBar.appearance().isHidden = true
            
            
        }
        .customSheet(isPresented: $halfModal) {
            HStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .cornerRadius(20, corners: [.topLeft])
                        .foregroundColor(firsthalfModal ? Color.greyscale6 : Color.spBlack)
                        .frame(maxHeight: 52)
                    HStack(spacing: 0) {
                        Spacer()
                        Text("수업 시작시간")
                        Spacer()
                    }.padding(.vertical, .padding.toComponents)
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        firsthalfModal = true
                    }
                }
                .padding([.leading, .top], -20)
                ZStack {
                    Rectangle()
                        .cornerRadius(20, corners: [.topRight])
                        .foregroundColor(firsthalfModal ? .spBlack : .greyscale6)
                        .frame(maxHeight: 52)
                    HStack(spacing: 0) {
                        Spacer()
                        Text("수업 종료시간")
                        Spacer()
                    }.padding(.vertical, .padding.toComponents)
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        firsthalfModal = false
                    }
                }
                .padding([.top, .trailing], -20)
            }.padding(.bottom, CGFloat.padding.toComponents)
            HStack(spacing: 0) {
                Text("\(selectedDay!) \(DateFormatUtil.classTimeFormatter(time: startTime)) - \(DateFormatUtil.classTimeFormatter(time: endTime))")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                Spacer()
            }
            DatePicker("", selection: firsthalfModal ? $startTime : $endTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding(.top, CGFloat.padding.toDifferentHierarchy)
                .padding(.bottom, CGFloat.padding.toDifferentHierarchy)
            Button(action: {
                withAnimation(.spring()) {
                    if firsthalfModal {
                        firsthalfModal.toggle()
                    } else {
                        classTimeInfo[selectedDay!]!["start"]! = startTime
                        classTimeInfo[selectedDay!]!["end"]! = endTime
                        halfModal.toggle()
                        firsthalfModal = true
                        
                    }
                }
            }, label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.spDarkBlue)
                    Text("다음")
                        .font(Font(uiFont: .systemFont(for: .button)))
                        .foregroundColor(.greyscale1)
                }
                .frame(maxHeight: 52)
            })
            .padding(.bottom, CGFloat.padding.toComponents)
        }
        .onDisappear{
            UITabBar.appearance().isHidden = false
        }
        
    }
    
    func save() {
        DispatchQueue.main.async {
            let classDay = dayList.filter{ isDayPicked[$0] == true }
            print(classDay)
            if !classDay.isEmpty {
                let classStartTime = classDay.map{ classTimeInfo[$0]?["start"] ?? Date()}
                let classEndTime = classDay.map{ classTimeInfo[$0]?["end"] ?? Date()}
                if classDay.count == classInfo?.classIterArray.count ?? 0 {
                    for i in 0..<classDay.count {
                        DataManager.shared.updateClassIteration(target: classInfo!.classIterArray[i], day: classDay[i], startTime: classStartTime[i], endTime: classEndTime[i])
                    }
                } else if (classDay.count > classInfo?.classIterArray.count ?? 0) {
                    if !(classInfo?.classIterArray.isEmpty ?? true) {
                        for i in 0..<classInfo!.classIterArray.count {
                            DataManager.shared.updateClassIteration(target: classInfo!.classIterArray[i], day: classDay[i], startTime: classStartTime[i], endTime: classEndTime[i])
                        }
                    }
                    for i in (classInfo?.classIterArray.count ?? 0)..<classDay.count {
                        DataManager.shared.addClassIteration(day: classDay[i], startTime: classStartTime[i] ?? Date(), endTime: classEndTime[i] ?? Date(), classInfo: classInfo!)
                    }
                } else {
                    for i in 0..<classDay.count {
                        DataManager.shared.updateClassIteration(target: classInfo!.classIterArray[i], day: classDay[i], startTime: classStartTime[i], endTime: classEndTime[i])
                    }
                    
                    for _ in classDay.count..<classInfo!.classIterArray.count {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                            DataManager.shared.deleteData(target: classInfo!.classIterArray[classDay.count])
                        }
                       
                    }
                }
            }
            if memberNames.count == memberSchools.count && memberNames.count == memberPhoneNumbers.count && !memberNames.isEmpty {
                if classInfo!.membersArray.count == memberNames.count {
                    for i in 0..<memberNames.count {
                        DataManager.shared.updateMembers(target: classInfo!.membersArray[i], name: memberNames[i], phoneNumber: memberPhoneNumbers[i], school: memberSchools[i])
                    }
                } else if (classInfo!.membersArray.count <= memberNames.count) {
                    for i in 0..<classInfo!.membersArray.count {
                        DataManager.shared.updateMembers(target: classInfo!.membersArray[i], name: memberNames[i], phoneNumber: memberPhoneNumbers[i], school: memberSchools[i])
                    }
                    for i in classInfo!.membersArray.count..<memberNames.count {
                        DataManager.shared.addMember(name: memberNames[i], phoneNumber: memberPhoneNumbers[i], classInfo: classInfo!, schoolString: memberSchools[i])
                    }
                } else {
                    for i in 0..<memberNames.count {
                        DataManager.shared.updateMembers(target: classInfo!.membersArray[i], name: memberNames[i], phoneNumber: memberPhoneNumbers[i], school: memberSchools[i])
                    }
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                        for _ in memberNames.count..<classInfo!.membersArray.count {
                            DataManager.shared.deleteData(target: classInfo!.membersArray[memberNames.count])
                            
                        }
                    }
                    
                }
            }
            
            classInfo = DataManager.shared.updateClassInfo(target: classInfo!, firstDate: firstClassDate, tuition: Int32(tuition), tuitionPer: Int16(tuitionPer), name: className, color: classInfo?.color ?? "", location: "")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }
        
        
        
    }
        
        
}


//
//  ClassExamAddView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/27.
//

import SwiftUI

struct ClassExamAddView: View {
    @State private var navBarHidden = true
    @State private var schoolName: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var examDay: [String] = []
    @State private var examInfo: [String] = []
    
    @FocusState var isSchoolFocused: Bool
    
    let day: TimeInterval = 60*60*24
    var dismissAction: (() -> Void)
    
    private func isDone() -> Bool {
        guard !schoolName.isEmpty && !examDay.isEmpty else {return false}
        return true
    }
    
    private func save() {
        DataManager.shared.addExamPeriod(name: schoolName, start: startDate.toDay, end: endDate.toDay, infos: examInfo)
    }
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: CGFloat.padding.toComponents) {
                    HStack(spacing: 0) {
                        Button(action: {
                            navBarHidden = false
                            dismissAction()
                        }, label: {
                            NavBarBackButton(title: "모든일정")
                        })
                        .padding([.top, .leading], 8)
                        Spacer()
                    }
                    ClassTitleProgressView(title: "시험기간 추가하기", progressBarWidth: UIScreen.main.bounds.width)
                }
                Text("학교명")
                    .font(.title3)
                    .foregroundColor(.greyscale1)
                    .padding(.top, .padding.toDifferentHierarchy)
                    .padding(.bottom, .padding.toTextComponents)
                    .padding(.horizontal, .padding.margin)
                
                ClassTextField(content: $schoolName, isFocused: $isSchoolFocused, placeholder: "학교를 입력하세요.")
                
                Text("언제부터 언제까지 시험을 보나요?")
                    .font(.title3)
                    .foregroundColor(.greyscale1)
                    .padding(.top, .padding.toDifferentHierarchy)
                    .padding(.bottom, .padding.toTextComponents)
                    .padding(.horizontal, .padding.margin)
                
                HStack(spacing: 0) {
                    let startDateBinding = Binding(
                        get: { startDate },
                        set: {
                            withAnimation(.spring()) {
                                examDay = []
                                examInfo = []
                            }
                            startDate = $0
                        }
                    )
                    DatePickerView(date: startDateBinding)
                    Text("부터")
                        .font(Font(uiFont: .systemFont(for: .body2)))
                        .foregroundColor(.greyscale1)
                        .padding(.leading, .padding.toText)
                    Spacer()
                }
                .padding(.horizontal, .padding.margin)
                .padding(.bottom, .padding.toComponents)
                
                HStack(spacing: 0) {
                    let endDateBinding = Binding(
                        get: { endDate },
                        set: {
                            endDate = $0
                            withAnimation(.spring()) {
                                examDay = []
                                examInfo = []
                            }
                            var tempStartDate = startDate.toDay
                            DispatchQueue.main.async {
                                while tempStartDate <= endDate.toDay {
                                    withAnimation(.spring()) {
                                        examDay.append(DateFormatUtil.classDateFormatter(time: tempStartDate))
                                        examInfo.append("")
                                    }
                                    tempStartDate += day
                                }
                            }
                        }
                    )
                    DatePickerView(date: endDateBinding)
                    Text("까지 시험을 봐요.")
                        .font(Font(uiFont: .systemFont(for: .body2)))
                        .foregroundColor(.greyscale1)
                        .padding(.leading, .padding.toText)
                    Spacer()
                }
                .padding(.horizontal, .padding.margin)
                .padding(.bottom, .padding.toComponents)
                
                ScrollView {
                    LazyVStack(spacing: CGFloat.padding.toComponents) {
                        ForEach(examDay.indices, id: \.self) { idx in
                            ZStack {
                                HStack(spacing: CGFloat.padding.inBox) {
                                    Text(examDay[idx] + "일")
                                        .font(Font(uiFont: .systemFont(for: .title3)))
                                        .foregroundColor(.greyscale1)
                                    TextField("", text: $examInfo[idx])
                                        .placeholder(when: examInfo[idx].isEmpty) {
                                            Text("시험 과목을 입력해주세요. (선택)")
                                                .foregroundColor(.greyscale4)
                                                .font(Font(uiFont: .systemFont(for: .body2)))
                                        }
                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                        .foregroundColor(.greyscale1)
                                    Spacer()
                                }
                                .padding(CGFloat.padding.inBox)
                                .background(
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.greyscale7)
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder((examInfo[idx] == "" ? Color.greyscale4 : Color.greyscale1), lineWidth: 1)
                                    }
                                )
                            }
                        }
                    }
                }
                .padding(.top, CGFloat.padding.toComponents)
                .padding(.horizontal, CGFloat.padding.margin)
                
                if !isSchoolFocused {
                    Button(action: {
                        withAnimation(.spring()) {
                            save()
                            dismissAction()
                        }
                    }, label: {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(isDone() ? .clear : .greyscale4)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.spLightBlue, Color.spDarkBlue]), startPoint: .trailing, endPoint: .leading))
                                .cornerRadius(10)
                            Text("저장하기")
                                .font(Font(uiFont: .systemFont(for: .button)))
                                .foregroundColor(.greyscale1)
                        }
                        .frame(maxHeight: 52)
                    })
                    .padding(.horizontal, CGFloat.padding.margin)
                    .padding(.bottom, CGFloat.padding.toComponents)
                    .disabled(!isDone())
                }
            }
        }
        .onTapGesture {
            isSchoolFocused = false
        }
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(true)
    }
}


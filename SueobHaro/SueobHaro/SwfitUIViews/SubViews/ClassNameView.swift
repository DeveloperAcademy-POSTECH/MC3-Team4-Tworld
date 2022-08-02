//
//  ClassNameView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/19.
//

import SwiftUI

struct ClassNameView: View {
    @Binding var viewMode: AddViewMode
    @Binding var className: String
    @Binding var firstClassDate: Date
    @Binding var isDayPicked: [String:Bool]
    @Binding var classTimeInfo: [String:[String:Date?]]
    
    @State var halfModal: Bool = false
    @State var selectedDay: String? = nil
    @State var firsthalfModal: Bool = true
    @State var startTime = Date()
    @State var endTime = Date()
    
    @FocusState private var isFocused: Bool
    
    let dayList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    let dateFormatter = DateFormatter()
    
    private func isDone() -> Bool {
        guard !className.isEmpty else { return false }
        guard Array(isDayPicked.values).contains(true) else { return false }
        for day in dayList {
            if isDayPicked[day]! && (classTimeInfo[day]!["start"]! == nil || classTimeInfo[day]!["end"]! == nil) {
                return false
            }
        }
        return true
    }
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                Text("수업명")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                    .padding(.bottom, CGFloat.padding.toText)
                
                ClassTextField(content: $className, isFocused: $isFocused, placeholder: "수업명을 입력하세요.")
                
                Text("언제부터 진행하나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                
                HStack(spacing: 0) {
                    DatePickerView(date: $firstClassDate)
                    Text("부터 수업을 진행해요.")
                        .font(Font(uiFont: .systemFont(for: .body2)))
                        .foregroundColor(.greyscale1)
                    Spacer()
                }
                .padding(.leading, CGFloat.padding.margin)
                .padding(.top, CGFloat.padding.inBox)
                
                Text("무슨 요일에 진행하나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                    .padding(.bottom, CGFloat.padding.toText)
                if !isFocused {
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
                                isDayPicked[day]?.toggle()
                                selectedDay = day
                                guard isDayPicked[day]! else { return }
                                withAnimation(.spring()){
                                    halfModal.toggle()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, CGFloat.padding.margin)
                    .frame(maxHeight: (UIScreen.main.bounds.width - (CGFloat.padding.margin*2 + CGFloat.padding.toText*6))/7)
                    
                    ScrollView {
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
                    }
                    .padding(.top, CGFloat.padding.toComponents)
                    .padding(.horizontal, CGFloat.padding.margin)
                    Button(action: {
                        withAnimation(.spring()) {
                            viewMode = .members
                        }
                    }, label: {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(isDone() ? .spDarkBlue : .greyscale4)
                            Text("다음")
                                .font(Font(uiFont: .systemFont(for: .button)))
                                .foregroundColor(.greyscale1)
                        }
                        .frame(maxHeight: 52)
                    })
                    .padding(.horizontal, CGFloat.padding.margin)
                    .padding(.bottom, CGFloat.padding.toComponents)
                    .disabled(!isDone())
                } else {
                    Spacer()
                }
            }
        }
        .onTapGesture {
            isFocused = false
        }
        .onAppear {
            dateFormatter.dateFormat = "HH:mm"
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
    }
}


struct CustomSheet<Content: View>: View {
    
    @Binding var isPresented: Bool
    
    let content: () -> Content
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isPresented = isPresented
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .padding(20)
        .padding(.bottom, 20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.greyscale6)
        )
        .frame(maxWidth: .infinity)
    }
}

struct CustomSheetViewModifier<InnerContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let innerContent: () -> InnerContent
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> InnerContent) {
        self._isPresented = isPresented
        self.innerContent = content
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 4 : 0)
            ZStack(alignment: .bottom) {
                if isPresented {
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isPresented = false
                            }
                        }
                        .transition(.opacity)
                    
                    CustomSheet(isPresented: $isPresented) {
                        innerContent()
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func customSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(CustomSheetViewModifier(isPresented: isPresented, content: content))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

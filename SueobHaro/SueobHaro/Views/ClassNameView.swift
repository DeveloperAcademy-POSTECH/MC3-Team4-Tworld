//
//  ClassNameView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/19.
//

import SwiftUI

struct ClassNameView: View {
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
    
    let dayList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: CGFloat.padding.toComponents) {
                    HStack {
                        Text("수업 추가하기")
                            .font(Font(uiFont: .systemFont(for: .title1)))
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.margin)
                            .padding(.top, CGFloat.padding.toComponents)
                        Spacer()
                    }
                    Rectangle()
                        .foregroundColor(.spLightBlue)
                        .frame(width: UIScreen.main.bounds.width/3, height: CGFloat(3), alignment: .leading)
                }
                
                Text("수업명")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.toBox)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                
                ZStack {
                    VStack(spacing: 4) {
                        TextField("", text: $className)
                            .placeholder(when: className.isEmpty) {
                                Text("수업명을 입력하세요")
                                    .foregroundColor(.greyscale3)
                                    .font(Font(uiFont: .systemFont(for: .body2)))
                            }
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.toBox)
                        Rectangle()
                            .foregroundColor(.greyscale3)
                            .frame(height: CGFloat(1))
                            .padding(.horizontal, CGFloat.padding.toBox)
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            className = ""
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.greyscale3)
                                .padding(.trailing, CGFloat.padding.toBox)
                                .padding(.bottom, 2)
                        })
                    }
                }
                
                Text("언제부터 진행하나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.toBox)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                
                HStack {
                    DatePicker("", selection: $firstClassDate, in: Date()..., displayedComponents: .date)
                        .changeTextColor(.spLightBlue)
                        .labelsHidden()
                    Text("부터 수업을 진행해요.")
                        .font(Font(uiFont: .systemFont(for: .body2)))
                        .foregroundColor(.greyscale1)
                    Spacer()
                }
                .padding(.leading, CGFloat.padding.toBox)
                .padding(.top, CGFloat.padding.inBox)
                
                Text("무슨 요일에 진행하나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.toBox)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                
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
                        }
                    }
                }
                .padding(.horizontal, CGFloat.padding.toBox)
                .frame(maxHeight: (UIScreen.main.bounds.width - (CGFloat.padding.toBox*2 + CGFloat.padding.toText*6))/7)
                
                ScrollView {
                    LazyVStack(spacing: CGFloat.padding.toComponents) {
                        ForEach(dayList, id: \.self) { day in
                            if isDayPicked[day]! {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).frame(maxHeight: CGFloat(60))
                                    HStack(spacing: CGFloat.padding.inBox) {
                                        Text(day)
                                            .font(Font(uiFont: .systemFont(for: .title3)))
                                            .foregroundColor(.greyscale1)
                                        if classTimeInfo[day]!["start"]! != nil && classTimeInfo[day]!["end"]! != nil {
                                            Text("\(classTimeInfo[day]!["start"]!!) ~ \(classTimeInfo[day]!["end"]!!)")
                                                .font(Font(uiFont: .systemFont(for: .body2)))
                                                .foregroundColor(.greyscale1)
                                        } else {
                                            Text("시간을 입력해주세요")
                                                .font(Font(uiFont: .systemFont(for: .body2)))
                                                .foregroundColor(.greyscale3)
                                                .onTapGesture {
//                                                    presentAlert.toggle()
                                                }
                                        }
                                        Spacer()
                                        Text("1주마다")
                                            .font(Font(uiFont: .systemFont(for: .body2)))
                                            .foregroundColor(.greyscale1)
                                    }.padding(CGFloat.padding.inBox)
                                }
                            }
                        }
                    }
                }
                .padding(.top, CGFloat.padding.toComponents)
                .padding(.horizontal, CGFloat.padding.toBox)
                NavigationLink(destination: {
                    ClassMembersView()
                }, label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.spDarkBlue)
                        Text("다음")
                            .font(Font(uiFont: .systemFont(for: .button)))
                            .foregroundColor(.greyscale1)
                    }
                    .padding(.horizontal, CGFloat.padding.margin)
                    .frame(maxHeight: 52)
                })
                .padding(.bottom, CGFloat.padding.toComponents)
            }
        }
    }
}

struct ClassNameView_Previews: PreviewProvider {
    static var previews: some View {
        ClassNameView()
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
    @ViewBuilder func changeTextColor(_ color: Color) -> some View {
        if UITraitCollection.current.userInterfaceStyle == .light {
            self.colorInvert().colorMultiply(color)
        } else {
            self.colorMultiply(color)
        }
    }
}


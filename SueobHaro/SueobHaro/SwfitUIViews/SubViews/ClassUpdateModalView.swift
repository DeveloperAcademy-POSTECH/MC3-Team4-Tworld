//
//  ClassUpdateModalView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/20.
//

import SwiftUI

struct ClassUpdateModalView: View {
    @State var inputText: String  = ""
    @Binding var selectedIndex: Int
    @Binding var isPresente: Bool
    @FocusState var isFocused
    @State var isAlertShow: Bool = false
    @Binding var isChanged: Bool
    @State var color: Color = Color(UIColor.theme.spLightBlue)
    @Binding var classTitle: String
    @Binding var classSchedule: [Schedule]
    
    
    var body: some View {
        if !classSchedule.isEmpty {
            VStack {
                Color.clear
                VStack(spacing:0) {
                    HStack {
                        Text(classTitle)
                            .foregroundColor(Color(UIColor.theme.greyscale1))
                            .font(Font(uiFont: .systemFont(for: .title2)))
                        Text("\(classSchedule.count)회차")
                            .font(Font(uiFont: .systemFont(for: .caption)))
                            .foregroundColor(Color(UIColor.theme.greyscale7))
                            .background{
                                Capsule()
                                    .frame(width: 42, height: 24, alignment: .center)
                                    .foregroundColor(Color(UIColor.theme.spLightBlue))
                            }
                            .padding(.leading, 11)
                        Spacer()
                    }
                    .padding(.top, CGFloat.padding.inBox)
                    HStack {
                        Text(getDate(date: classSchedule[selectedIndex].startTime ?? Date()))
                            .font(Font(uiFont: .systemFont(for: .body1)))
                            .foregroundColor(Color(UIColor.theme.greyscale1))
                            .padding(.trailing, 9)
                        Text("13:00~15:00")
                            .font(Font(uiFont: .systemFont(for: .body1)))
                            .foregroundColor(Color(UIColor.theme.greyscale3))
                        Spacer()
                    }
                    .padding(.top, CGFloat.padding.toText)
                    .padding(.bottom, CGFloat.padding.inBox)
                    HStack {
                        Text("진행 상황")
                            .font(Font(uiFont: .systemFont(for: .body1)))
                            .foregroundColor(Color(UIColor.theme.greyscale3))
                            .padding(.bottom, CGFloat.padding.toText)
                        Spacer()
                    }
                    
                    TextField("", text: $inputText)
                        .font(Font(uiFont: .systemFont(for: .body2)))
                        .foregroundColor(Color(UIColor.theme.greyscale1))
                        .focused($isFocused)
                        
                    Divider()
                        .background(color)
                        .padding(.bottom, 71.58)
                    Button(action: {
                        if inputText != ""{
    //                        progressList[selectedIndex] = inputText
                            if inputText != classSchedule[selectedIndex].progress ?? "" {
                                classSchedule[selectedIndex].progress = inputText
                                DataManager.shared.updateSchedule(target: classSchedule[selectedIndex], count: nil, endTime: nil, startTime: nil, isCanceled: nil, progress: nil)
                                isChanged.toggle()
                            }
                            isFocused = false
                            isPresente = false

                        } else {
                            isAlertShow = true
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            Text("저장하기")
                                .font(Font(uiFont: .systemFont(for: .button)))
                                .foregroundColor(Color(UIColor.theme.greyscale1))
                            Spacer()
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(colors: inputText != "" ? [Color(UIColor.theme.spLightBlue), Color(UIColor.theme.spDarkBlue)] : [Color(UIColor.theme.greyscale3)], startPoint: .leading, endPoint: .trailing))
                                .frame(height:52)
                                
                        }
                        .padding(.bottom, 20)
                        
                        
                    })
                    .alert("수업 진도 입력", isPresented: $isAlertShow) {
                        Button(role: .cancel) {} label: { Text("확인") }
                    } message: {
                        Text("수업 진도를 입력해 주세요")
                    }
                        
                }
                .background{
                    Rectangle()
                        .fill(Color(UIColor.theme.greyscale6))
                        .cornerRadius(radius: 10.0, corners: [.topLeft, .topRight])
                        .frame(width: UIScreen.main.bounds.size.width)
                        .ignoresSafeArea(edges: .bottom)
                        
                        
                }.ignoresSafeArea()
                
            }
            .onChange(of: isPresente) { _ in
                if isPresente {
                    inputText = classSchedule[selectedIndex].progress ?? ""
                    isFocused = true
                }
            }
            .onChange(of: isFocused ) { _ in
                if isFocused {
                    withAnimation {
                        color = Color(UIColor.theme.spLightBlue)
                    }
                } else {
                    if inputText == "" {
                        withAnimation {
                            color = Color(UIColor.theme.greyscale4)
                        }
                    } else {
                        withAnimation{
                            color = Color(UIColor.theme.greyscale1)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .background{
                Color.black.opacity(0.7)
                    .onTapGesture {
                        if !isFocused {
                            withAnimation {
                                isPresente = false
                            }
                        } else {
                            isFocused = false
                        }
                    }
                    .ignoresSafeArea()
                
            }
        } else {
            Text("비어있으")
        }
        
        
    }
            
    func getDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        
        dateFormatter.dateFormat = "yyyy.MM.dd (E)" // Date 포맷 타입 지정
        let date_string = dateFormatter.string(from: date) // 포맷된 형식 문자열로 반환

        return date_string
    }
    
    func getTime(date: Date) -> String {
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        
        dateFormatter.dateFormat = "kk:mm:ss" // Date 포맷 타입 지정
        let date_string = dateFormatter.string(from: date) // 포맷된 형식 문자열로 반환

        return date_string
    }
            
}

struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}


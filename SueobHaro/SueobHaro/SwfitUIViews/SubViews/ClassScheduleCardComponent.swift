//
//  ClassScheduleCardComponent.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/20.
//

import SwiftUI

struct ClassScheduleCardComponent: View {
    
    @State var dateTime: Date = Date()
    @State var time:String = "13:00~15:00"
    @State var count:Int = 4
    @Binding var classSchedule: Schedule
    @State var myIndex: Int = 0
    @Binding var selectedIndex: Int?
    @State var inputText: String = ""
    @FocusState var isFocused: Bool
    @Binding var scheduleList: [Schedule]
    @State var isAlertShowing: Bool = false
    @State var originalProgress: String = ""
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(getDate(date:classSchedule.startTime ?? Date()))
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(Color(UIColor.theme.greyscale1))
                Spacer()
                Text("\(classSchedule.count)회차")
                    .font(Font(uiFont: .systemFont(for: .caption)))
                    .foregroundColor(Color(UIColor.theme.greyscale7))
                    .background{
                        Capsule()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.theme.spLightBlue), Color(UIColor.theme.spDarkBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 42, height: 24, alignment: .center)
                    }
                    .padding(.trailing, CGFloat.padding.inBox)
            }
            .padding(.top, CGFloat.padding.inBox)
            .padding(.leading, CGFloat.padding.inBox)
//            .padding(.trailing, CGFloat.padding.inBox)
            HStack {
                Text("\(getTime(date:classSchedule.startTime ?? Date()))~\(getTime(date:classSchedule.endTime ?? Date()))")
                    .foregroundColor(Color(UIColor.theme.greyscale3))
                    .font(Font(uiFont: .systemFont(for: .body1)))
                Spacer()
                
            }
            .padding(.horizontal, CGFloat.padding.inBox)
            .padding(.top, CGFloat.padding.toText)
            .padding(.bottom, CGFloat.padding.inBox)
            Divider()
                .background(Color(UIColor.theme.greyscale3))
            ZStack {
                VStack {
                    HStack {
                        if inputText.isEmpty {
                            Image(systemName: "highlighter")
                                .resizable()
                                .foregroundColor(isFocused ? .greyscale4 : Color(UIColor.theme.spLightBlue))
                                .frame(width: 20, height: 20)
                        }
                        Text(inputText.isEmpty ? "수업의 진행 상황을 입력해주세요." : isFocused ? "" : inputText)
                            .foregroundColor(isFocused ? .greyscale4 : inputText.isEmpty ? Color(UIColor.theme.spLightBlue) : selectedIndex == myIndex ? Color.clear : Color(UIColor.theme.greyscale1))
                            .font(Font(uiFont: .systemFont(for: .body2)))
                        
                        Spacer()
                    }
                    .padding(.top , isFocused ? 7 : 0)
                    .padding(.horizontal , isFocused ? 7 : 0)
                    Spacer()
                    
                }
                
                .padding(.horizontal, CGFloat.padding.inBox)
                .padding(.top, CGFloat.padding.inBox)
                .padding(.bottom, CGFloat.padding.inBox)
                ZStack {
                    TextEditor(text: $inputText)
                        .foregroundColor(isFocused ? .greyscale1 : selectedIndex == myIndex ? .greyscale1 : Color.clear)
                        .focused($isFocused)
    //                    .background(isFocusing ? .greyscale7 : Color.clear)
                    if isFocused {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("\(inputText.count)/100자")
                                    .font(Font(uiFont: .systemFont(for: .body1)))
                                    .foregroundColor(inputText.count > 100 ? .red:.greyscale4)
                            }
                        }
                    }
                    
                }
                .frame(height: myIndex == selectedIndex ? 146.34 : 0)
                .padding(.horizontal, CGFloat.padding.inBox)
                .padding(.top, CGFloat.padding.inBox)
                .padding(.bottom, CGFloat.padding.inBox)
                
                    
                
            }
            .onAppear{
                // render시 inputText에 기존 값 할당
                inputText = classSchedule.progress ?? ""
                // 오리지날 데이터를 넣어, 기존 값과 다른 경우에 따라 취소 버튼에 기존 값을 할당해 주기 위한 임시 변수
                originalProgress = classSchedule.progress ?? ""
            }
            .onChange(of: selectedIndex, perform: { i in
                if myIndex == selectedIndex {
                    // selectedIndex가 해당 카드의 인덱스 값과 같은 경우, 텍스트 에디터에 포커싱을 준다
                    isFocused = true
                } else {
                    isFocused = false
                }
            })
            .onChange(of: inputText, perform: { _ in
                if myIndex == selectedIndex {
                    // ClassDetailView 에서 저장 버튼을 클릭시 저장이 가능하도록 해당 엔티티에 값을 할당해 준다.
                    scheduleList[myIndex].progress = inputText
                }
            })
            
        }
        .alert("저장하지 않고 나가기", isPresented: $isAlertShowing) {
            Button("취소", role: .cancel) {}
            Button("나가기", role: .destructive) {
                
                selectedIndex = nil
                inputText = originalProgress
            }
            
        } message: {
            Text("작성한 내용을 저장하지 않은 상태로 나가면 이 정보는 남아있지 않아요🥲")
        }
      
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.theme.greyscale7))
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.theme.greyscale5), lineWidth: 1)
        }
        .onTapGesture {
            if myIndex == selectedIndex {
                isAlertShowing = true
            } else {
                // 선택된 카드가 없을 경우에만 카드 컴퍼넌트 클릭이 동작을 하게 만들어 선택하게 한다.
                if selectedIndex == nil {
                    withAnimation {
                        selectedIndex = myIndex
                        
                    }
                }
            }
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
        
        dateFormatter.dateFormat = "kk:mm" // Date 포맷 타입 지정
        let date_string = dateFormatter.string(from: date) // 포맷된 형식 문자열로 반환

        return date_string
    }
    

}


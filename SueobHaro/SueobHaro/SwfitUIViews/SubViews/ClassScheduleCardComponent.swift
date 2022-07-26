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
            HStack {
                Image(systemName: "highlighter")
                    .resizable()
                    .foregroundColor(Color(UIColor.theme.spLightBlue))
                    .frame(width: 20, height: 20)
                if classSchedule.progress == "" {
                    Text("수업의 진행 상황을 입력해주세요.")
                        .foregroundColor(Color(UIColor.theme.spLightBlue))
                        .font(Font(uiFont: .systemFont(for: .body2)))
                } else {
                    Text(classSchedule.progress ?? "")
                        .foregroundColor(Color(UIColor.theme.greyscale1))
                        .font(Font(uiFont: .systemFont(for: .body2)))
                }
                Spacer()
            }
            .padding(.horizontal, CGFloat.padding.inBox)
            .padding(.top, CGFloat.padding.inBox)
            .padding(.bottom, CGFloat.padding.inBox)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.theme.greyscale7))
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.theme.greyscale5), lineWidth: 1)
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


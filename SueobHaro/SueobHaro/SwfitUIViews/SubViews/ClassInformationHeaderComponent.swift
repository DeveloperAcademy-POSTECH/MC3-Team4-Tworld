//
//  ClassInformationHeaderComponent.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/21.
//

import SwiftUI

struct ClassInformationHeaderComponent: View {
    
    @Binding var classTitle: String
    @Binding var memberList: [String]
    @State var date: Date = Date()
    @Binding var classInfo: ClassInfo?
    
    var body: some View {
        VStack(spacing: 0) {
            Text(classTitle)
                .font(Font(uiFont: .systemFont(for: .title2)))
                .foregroundColor(Color(UIColor.theme.greyscale1))
                .padding(.top, CGFloat.padding.inBox)
                .padding(.bottom, CGFloat.padding.toText)
            HStack(spacing: 0) {
                if memberList.count > 0 {
                    ForEach(0..<memberList.count, id: \.self) { i in
                        Text(memberList[i])
                            .font(Font(uiFont: .systemFont(for: .body1)))
                            .foregroundColor(Color(UIColor.theme.greyscale3))
                        if i != memberList.count - 1 {
                            Text(", ")
                                .font(Font(uiFont: .systemFont(for: .body1)))
                                .foregroundColor(Color(UIColor.theme.greyscale3))
                        }
                        
                    }
                }
            }
            .padding(.top, 0)
            .padding(.bottom, CGFloat.padding.inBox)
            
            Divider()
                .background(Color(UIColor.theme.greyscale6))
            
            Text("\(getDate(date:date)) 부터 수업을 진행했어요")
                .font(Font(uiFont: .systemFont(for: .body2)))
                .foregroundColor(Color(UIColor.theme.greyscale1))
                .padding(.top, CGFloat.padding.inBox)
                .padding(.bottom, CGFloat.padding.toText)
            Text("\(classInfo?.tuitionPer ?? 0)회마다 총 \(classInfo?.tuition ?? 0)원 받아요.")
                .font(Font(uiFont: .systemFont(for: .title3)))
                .foregroundColor(Color(UIColor.theme.greyscale1))
                .padding(.bottom, CGFloat.padding.inBox)
        }
        .frame(width: UIScreen.main.bounds.size.width - 32)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(UIColor.theme.greyscale7))
                .frame(width: UIScreen.main.bounds.size.width - 32, height: 182)
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.theme.spLightBlue), lineWidth: 1)
                .frame(width: UIScreen.main.bounds.size.width - 32, height: 182)
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

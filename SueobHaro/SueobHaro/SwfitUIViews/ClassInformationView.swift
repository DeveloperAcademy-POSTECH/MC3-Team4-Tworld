//
//  ClassInformationView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/21.
//

import SwiftUI

struct ClassInformationView: View {
    
    // 클래스 정보 받아오기
    @Binding var classTitle: String
    @Binding var classInfo: ClassInfo?
    
    // 클래스에 해당하는 멤버 받아오기
    @Binding var memberList: [Members]
    
    
    @State var memberNames: [String] = []
    @State var memberSchools: [String] = []
    @State var memberPhoneNumbers: [String] = []
    
    
    @State var iterClass: [[String]] = [["수", "13:00"], ["토", "16:00"]]
    @State var members: [[String]] = [["최세영", "010-4444-4444"], ["최세영", "010-4444-4444"],["최세영", ""],["최세영", "010-4444-4444"],["최세영", "010-4444-4444"]]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ClassInformationHeaderComponent(classTitle: $classTitle, memberList: $memberList, classInfo: $classInfo)
                .padding(.horizontal, 16)
                .padding(.top, 12)
            HStack {
                Text("수업 일정")
                    .font(.title3)
                    .foregroundColor(Color(UIColor.theme.greyscale1))
                Spacer()
            }
            .padding(.top, CGFloat.padding.toDifferentHierarchy)
            .padding(.bottom, CGFloat.padding.toTextComponents)
            .padding(.horizontal, 16)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.greyscale6, lineWidth: 1)
                    .background(Color.spBlack)
                VStack(spacing: CGFloat.padding.inBox) {
                    ForEach(Array((classInfo?.classIterArray ?? []).enumerated()), id: \.offset) { index, value in
                        ClassInformationListComponent(firstText: value.day ?? "", secondText: (getTime(date: value.startTime ?? Date()) + "-" + getTime(date: value.endTime ?? Date())))
                        if index != (classInfo?.classIterArray.count ?? 1) - 1 {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.greyscale6)
                        }
                    }
                }.padding(.vertical, CGFloat.padding.inBox)
            }
            .padding(.horizontal, 16)
            
//            .background{
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color(UIColor.theme.greyscale3), lineWidth: 1)
//            }
//
            
            HStack {
                Text("참여자")
                    .font(.title3)
                    .foregroundColor(Color(UIColor.theme.greyscale1))
                Spacer()
                    
            }
            .padding(.top, CGFloat.padding.toDifferentHierarchy)
            .padding(.bottom, CGFloat.padding.toTextComponents)
            .padding(.horizontal, 16)
            
//            VStack(spacing: CGFloat.padding.inBox) {
//                ForEach(Array((classInfo?.membersArray ?? []).enumerated()), id: \.offset) { index, value in
//                    ClassInformationListComponent(firstText: value.name ?? "", secondText: value.phoneNumber ?? "")
//                    if index != (classInfo?.membersArray.count ?? 1) - 1 {
//                        Rectangle()
//                            .frame(height: 1)
//                            .foregroundColor(Color.greyscale6)
//                    }
//                }
//            }
//            .background{
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color(UIColor.theme.greyscale3), lineWidth: 1)
//            }
//            .padding(.horizontal, 16)
            
                
            ClassMemberGridView(memberNames: memberNames, memberSchools: memberSchools, memberPhoneNumbers: memberPhoneNumbers, backgroundColor: .greyscale7, strokeColor: .spTurkeyBlue)
                 .padding(.horizontal, 16)
                    
                
            
        }
        .onAppear{
            for member in memberList {
                memberNames.append(member.name ?? "")
                memberSchools.append("태양초등학교")
                memberPhoneNumbers.append(member.phoneNumber ?? "")
                
            }
        }
        .toolbar {
            NavigationLink("편집", destination: ClassUpdateView(classInfo: $classInfo))
                .tint(.spLightBlue)
        }
        .background{
            Color(UIColor.theme.spBlack)
                .ignoresSafeArea()
        }
    }
    
    func getTime(date: Date) -> String {
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        
        dateFormatter.dateFormat = "kk:mm" // Date 포맷 타입 지정
        let date_string = dateFormatter.string(from: date) // 포맷된 형식 문자열로 반환

        return date_string
    }
}


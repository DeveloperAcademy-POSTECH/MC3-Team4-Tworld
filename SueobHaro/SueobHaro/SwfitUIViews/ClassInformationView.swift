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
    @State var classIter: [ClassIteration] = []
    
    @State var memberNames: [String] = []
    @State var memberSchools: [String] = []
    @State var memberPhoneNumbers: [String] = []
    
    
    var body: some View {
        ScrollView() {
            LazyVStack {
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
                        ForEach(0..<classIter.count, id: \.self) { index in
                            ClassInformationListComponent(firstText: classIter[index].day ?? "", secondText: (getTime(date: classIter[index].startTime ?? Date()) + "-" + getTime(date: classIter[index].endTime ?? Date())))
                            if index != (classInfo?.classIterArray.count ?? 1) - 1 {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.greyscale6)
                            }
                        }
                    }.padding(.vertical, CGFloat.padding.inBox)
                }
                .padding(.horizontal, 16)
                
                HStack {
                    Text("참여자")
                        .font(.title3)
                        .foregroundColor(Color(UIColor.theme.greyscale1))
                    Spacer()
                        
                }
                .padding(.top, CGFloat.padding.toDifferentHierarchy)
                .padding(.bottom, CGFloat.padding.toTextComponents)
                .padding(.horizontal, 16)
                
                member(members: memberList, backgroundColor: .greyscale7, strokeColor: .spTurkeyBlue)
                    .padding(.horizontal, 16)
            }
            
        }
        .onAppear{
            memberList = DataManager.shared.getMembers(classInfo: classInfo!)
            classIter = DataManager.shared.getClassIters(classInfo: classInfo!)
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
    
    @ViewBuilder
    func member(members: [Members], backgroundColor: Color, strokeColor: Color) -> some View {
        let columnLayout = Array(repeating: GridItem(), count: 2)
        LazyVGrid(columns: columnLayout) {
            ForEach(members) { data in
                NavigationLink(destination: PersonalMemberView(member: data)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(backgroundColor)
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(strokeColor, lineWidth: 1)
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(data.name ?? "")
                                    .font(Font(uiFont: .systemFont(for: .title3)))
                                    .foregroundColor(Color.greyscale1)
                                    .padding(.bottom, .padding.toText)
                                Text(data.school?.name ?? "")
                                    .font(Font(uiFont: .systemFont(for: .body1)))
                                    .foregroundColor(Color.greyscale3)
                                Text(data.phoneNumber ?? "")
                                    .font(Font(uiFont: .systemFont(for: .body1)))
                                    .foregroundColor(Color.greyscale3)
                            }
                            Spacer()
                        }.padding(.padding.inBox)
                    }
                }
                
            }
        }
    }
}


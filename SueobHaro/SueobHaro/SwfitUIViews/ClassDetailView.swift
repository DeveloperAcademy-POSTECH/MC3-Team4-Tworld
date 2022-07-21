//
//  ClassDetailView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/20.
//

import SwiftUI

struct ClassDetailView: View {
    
    // 클래스 정보 받아오기
    @State var classTitle: String = "코딩 영재반"
    // 클래스에 해당하는 멤버 받아오기
    @State var memberList: [String] = ["사샤", "에반", "린다", "베테브", "엑스"]
    
    // 클래스에 해당하며, 금일 날짜 기준에 이전 날짜 정보 받아오기
    @State var progressList: [String] = ["", "UIKit Table View", "UIKit TextField", "UIKit CollectionView", "UIKit TableView Cell"]
    
    @State var editProgress:String = ""
    @State var selectedIndex: Int = 0
    @State var isPresented: Bool = false
    @State var selectedClass: ClassInfo?
    @State var classSchedules: [Schedule] = []
    @State var members:[Members] = []
    @State var isChanged: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                NavigationLink(destination: ClassInformationView(classTitle: $classTitle, memberList: $memberList)) {
                    //수업정보와, 멤버 이름 들어감
                    ClassHeaderComponent(classTitle: $classTitle, memberList: $memberList)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                }
                HStack {
                    Text("수업 노트")
                        .font(.title3)
                        .foregroundColor(Color(UIColor.theme.greyscale1))
                        .padding(.top, CGFloat.padding.toDifferentHierarchy)
                        .padding(.bottom, CGFloat.padding.toTextComponents)
                    Spacer()
                }.padding(.horizontal, 16)
                
                if progressList.isEmpty {
                    VStack {
                        Text("아직 수업을 한번도 진행하지 않았어요!")
                            .font(.body)
                            .foregroundColor(Color(UIColor.theme.greyscale3))
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 32, height: 142)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(UIColor.theme.greyscale7))
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(UIColor.theme.greyscale6), lineWidth: 1)
                    }
                    .padding(.horizontal, 16)
                    
                } else {
                    ForEach(Array(progressList.enumerated()), id: \.offset) { index, value in
                        //스케쥴 카드 컴퍼넌트 들어감
                        ClassScheduleCardComponent(progress: $progressList[index])
                            .padding(.horizontal, 16)
                            .padding(.bottom, CGFloat.padding.toComponents)
                            .onTapGesture {
                                withAnimation{
                                    isPresented = true
                                    editProgress = progressList[index]
                                    selectedIndex = index
                                }
                            }
                    }
                }
                
            }
            .background{
                Color(UIColor.theme.spBlack)
                    .ignoresSafeArea()
            }
            ClassUpdateModalView(inputText: $editProgress,selectedIndex: $selectedIndex, progressList: $progressList, isPresente: $isPresented, isChanged: $isChanged)
                .offset(y: isPresented ? 0 : UIScreen.main.bounds.height + 100)
            
            
        }
        .navigationBarBackButtonHidden(isPresented)
        .onAppear {
            DataManager.shared.fetchData(target: .schedule)
            DataManager.shared.fetchData(target: .members)
            classSchedules = DataManager.shared.schedule ?? []
            classSchedules = classSchedules.filter{ $0.classInfo == selectedClass }
            members = DataManager.shared.members ?? []
            members = members.filter{ $0.classInfo == selectedClass }
            
        }
        .onChange(of: isChanged) { _ in
            classSchedules = DataManager.shared.schedule ?? []
            classSchedules = classSchedules.filter{ $0.classInfo == selectedClass }
        }
        
    }
}

struct ClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClassDetailView()
    }
}

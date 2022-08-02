//
//  ClassDetailView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/20.
//

import SwiftUI

struct ClassDetailView: View {
    
//    @ObservedObject var keyboardHelper = UIKeyboardHeightHelper()
    @Environment(\.presentationMode) var presentationMode
    // OnAppear 에서 선택된 클래스에 대한 타이틀값을 할당 받는다
    @State var classTitle: String = "코딩 영재반"
    //    @State var isPresented: Bool = false
    // 클래스에 해당하며, 금일 날짜 기준에 이전 날짜 정보 받아오기
    
    // 수업 진도 클릭 시 스케쥴 인덱스 값
    // 인덱스 값의 변화를 통해, 선택 여부, DetailView와 ScheduleCardComponent와의 동시 반응으 작동시킨다.
    // 또한 빠른 노트에서 선택하여 들어올 경우 해당 스케쥴의 인덱스값을 OnAppear에서 할당 받는다.
    @State var selectedIndex: Int?
    // 선택한 클래스에 대한 정보 할당
    @State var selectedClass: ClassInfo?
    // 선택한 클래스의 값을 이용하여 OnAppear에서 스케쥴 값 Fetch
    @State var classSchedules: [Schedule] = []
    // 선택한 클래스의 값을 이용하여 OnAppear에서 멤버 값 Fetch
    @State var members:[Members] = []
    // 선택한 스케쥴 Entity
    @State var selectedSchedule: Schedule?
    @State var isChanged: Bool = false
    
    //
    @State var isScrollDisable: Bool = false
    // 키보드가에 따라 스크롤 뷰 바텀 패팅값을 준다(갯수가 적을 때 스크롤 안되는 것 방지)
    @State var bottomPadding: CGFloat = 0
    // 네비게이션 바 타이틀 값을 할당 받는 기준의 값
    @State var isOffset: CGFloat = .zero
    // 네비게이션 바 타이틀 노출 여부
    @State var isNavigationTitle: Bool = false
    
    @State var isOut:Bool = false
    @State var nextSchedule:Schedule?
    
    var dismissAction: (() -> Void)
    
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { proxy in

                    //수업정보와, 멤버 이름 들어감
                        
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 8, height: 8)
                                .padding(.trailing, CGFloat.padding.toText)
                            Text(classTitle)
                                .font(Font(uiFont: .systemFont(for: .title2)))
                                .foregroundColor(.greyscale1)
                            
                            Spacer()
                            NavigationLink(destination: ClassInformationView(classTitle: $classTitle, classInfo: $selectedClass ,memberList: $members)) {
                                Text("더보기 +")
                                    .font(Font(uiFont: .systemFont(for: .body1)))
                                    .foregroundColor(.spLightBlue)
                            }
                        }
                        .padding(.bottom, CGFloat.padding.toText)
                        HStack(spacing: 0) {
                            ForEach(0..<members.count, id: \.self) { i in
                                Text(i != members.count - 1 ? "\(members[i].name ?? ""), " : "\(members[i].name ?? "")")
                                    .font(Font(uiFont: .systemFont(for: .body1)))
                                    .foregroundColor(.greyscale3)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, CGFloat.padding.toTextComponents)
                    Rectangle()
                        .fill(Color(UIColor.theme.greyscale5))
                        .frame(height:1)
                        .frame(maxWidth:.infinity)
                    
                    if let data = nextSchedule {
//                        if selectedSchedule == nil
                            VStack(spacing: 0) {
                                HStack {
                                    Text("다음 수업")
                                        .font(Font(UIFont.systemFont(for: .title3)))
                                        .foregroundColor(.greyscale1)
                                }
                                .padding(.horizontal, CGFloat.padding.margin)
                                .padding(.vertical, CGFloat.padding.toTextComponents)
                                VStack {
                                    HStack {
                                        Text(getDate(date: data.startTime ?? Date()))
                                            .font(Font(uiFont: .systemFont(for: .title3)))
                                            .foregroundColor(Color(UIColor.theme.greyscale1))
                                        Spacer()
                                        Text("\(data.count)회차")
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

                                    HStack {
                                        Text("\(getTime(date:data.startTime ?? Date()))~\(getTime(date:data.endTime ?? Date()))")
                                            .foregroundColor(Color(UIColor.theme.greyscale3))
                                            .font(Font(uiFont: .systemFont(for: .body1)))
                                        Spacer()
                                        
                                    }
                                    .padding(.horizontal, CGFloat.padding.inBox)
                                    .padding(.top, CGFloat.padding.toText)
                                    .padding(.bottom, CGFloat.padding.inBox)
                                    
                                    Button(action: {
                                        if data.isCanceled {
                                            DataManager.shared.updateSchedule(target: data, count: data.count, endTime: data.endTime, startTime: data.startTime, isCanceled: false, progress: data.progress)
                                        } else {
                                            DataManager.shared.updateSchedule(target: data, count: data.count, endTime: data.endTime, startTime: data.startTime, isCanceled: true, progress: data.progress)
                                        }
                                        let someThing = DataManager.shared.fetchSchedules(section: .next)
                                        nextSchedule = nil
                                        if !someThing.isEmpty {
                                            nextSchedule = someThing[0]
                                        }
                                        
                                    }, label: {
                                        ZStack {
                                            Rectangle()
                                                .fill(Color(UIColor.theme.greyscale6))
                                                .cornerRadius(radius: 10.0, corners: [.bottomLeft, .bottomRight])
                                                .frame(width: UIScreen.main.bounds.size.width - (CGFloat.padding.margin * 2))
                                            Text("\(data.isCanceled ?"휴강취소" : "휴강하기")")
                                                .font(Font(UIFont.systemFont(for: .button)))
                                                .foregroundColor(.greyscale2)
                                                .padding(.vertical, CGFloat.padding.inBox)
                                        }
                                        
                                            
                                            
                                    })
                                }
                                .background {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(UIColor.theme.greyscale7))
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(UIColor.theme.greyscale5), lineWidth: 1)
                                    }
                                    
                                }
                                .padding(.horizontal, CGFloat.padding.margin)
                                
                            }
                            
                            
                        
                    
                    }
                        
                       
                    HStack {
                        Text("수업 노트")
                            .font(Font(uiFont: .systemFont(for: .title3)))
                            .foregroundColor(Color(UIColor.theme.greyscale1))
                            .padding(.top, CGFloat.padding.toDifferentHierarchy)
                            .padding(.bottom, CGFloat.padding.toTextComponents)
                        Spacer()
                    }.padding(.horizontal, 16)
                    
                    if classSchedules.isEmpty {
                        VStack {
                            Text("아직 수업을 한번도 진행하지 않았어요!")
                                .font(Font(uiFont: .systemFont(for: .body1)))
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
                        ForEach(Array($classSchedules.enumerated()), id: \.offset) { index, value in
                            //스케쥴 카드 컴퍼넌트 들어감
                            ClassScheduleCardComponent(classSchedule: value, myIndex: index, selectedIndex: $selectedIndex, scheduleList: $classSchedules)
                                .id(index)
                                .padding(.horizontal, 16)
                                .padding(.bottom, CGFloat.padding.toComponents)
                        }
                        
                        .onChange(of: selectedIndex) { _ in
                            if let scrollIndex = selectedIndex {
                                // 시간 순서에 따라 렌더에 영향을 주지 않게 하기 위해 시간 차이를 준다
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                                    withAnimation{
                                        // 데이터가 적을 시 스크롤이 되지 않는 문제를 해결하기 위해 바텀 패딩을 준다
                                        bottomPadding = 260
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                            // 패딩으로 스크롤이 가능하게 되면 선택한 카드의 id 값에 해당하는 것으로 스크롤뷰에 바텀에 위치시킨다.
                                            proxy.scrollTo(scrollIndex, anchor: .bottom)
//                                        isScrollDisable = true
                                        }
                                    }
                                }
                            } else {
                                // 선택이 해제가 되는 경우로 패딩을 원상 복귀 한다.
                                bottomPadding = 0
                                // 선택이 해제되는 경우는 데이터 값의 변화가 있던지, 작성 중이 내용을 취소한 경우로 스케쥴 데이터를 다시 fetch 하여 해당 값을 refresh 해준다
                                classSchedules = DataManager.shared.getSchedules(classInfo: selectedClass!)
                                print("is OUt \(isOut)")
                                if isOut {
                                    self.presentationMode.wrappedValue.dismiss()
                                    dismissAction()
                                }
                            }
                        }
                        .onAppear{
                            // 빠른 노트에서 스케쥴을 선택하고 들어온 경우 포커싱을 주기 위해 값을 확인하여 selectedIndex 값의 변화를 준다
                            if let schdule = selectedSchedule {
//                                print(classSchedules.firstIndex(of: schdule))
                                // 변화를 줄때 렌더되는 과정가 동시에 일어나게 되면 충돌로 텍스트 에디터에 포커싱을 주는 로직이 씹히는 상황이 발생하여 그것을 예방하기 위해 약간의 시간을 준 후 값을 변화시킨다.
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                    selectedIndex = classSchedules.firstIndex(of: schdule)
                                }
                            }
                            
                        }
                    }
                        
                    
                }
                .background(GeometryReader {
                    // 스크롤 값을 확인한다.
                    Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) {
                    isOffset = $0
                    // 스크롤 값에 일정 수치 이상이 되는 경우 네비게이션 타이틀에 클래스 타이틀 값을 주기 위한 판단 로직
                    if $0 > 60 {
                        withAnimation {
                            isNavigationTitle = true
//                            print(isNavigationTitle)
                        }
                    } else {
                        withAnimation{
                            isNavigationTitle = false
                        }
                    }
                   
                }
            }
            // 추후 스케쥴 선택 시 스크롤이 안되게 하는 것을 고려 중
            // 현재 스크롤 불가와 키보드 보여지는 것이 동시에 일어나게 되면 충돌로 키보드가 안보이는 문제가 있어 현재는 사용하지 않는다.
            .disabled(isScrollDisable)
            .padding(.bottom, bottomPadding)
            .ignoresSafeArea(.keyboard)
            .background{
                Color(UIColor.theme.spBlack)
                    .ignoresSafeArea()
            }
            
            .coordinateSpace(name: "scroll")
            
        }
        // 스크롤 값에 따라 네비게이션 타이틀 노출 여부 결정
        .navigationBarTitle(isNavigationTitle ? classTitle : "", displayMode: .inline)
//        .navigationBarHidden(!isNavigationTitle)
        .toolbar {
            if isOffset > 60 {
                NavigationLink("더보기", destination: ClassInformationView(classTitle: $classTitle, classInfo: $selectedClass ,memberList: $members))
                    .tint(.spLightBlue)
            }
        }
        .toolbar {
            // 키보드에 저장 버튼을 둔다
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: {
                    if let index = selectedIndex {
                        if let progress = classSchedules[index].progress, !progress.isEmpty {
                            if progress.count <= 100 {
                                DispatchQueue.main.async {
                                    DataManager.shared.updateSchedule(target: classSchedules[index], count: nil, endTime: nil, startTime: nil, isCanceled: nil, progress: nil)
                                }
                                selectedIndex = nil
                            }

                        } else {
//                            print("값을 입력한 후 저장해 주세요")
                        }
                    }
                    
                   
                }, label: {
                    
                    Text("저장하기")
                        .font(Font(uiFont: .systemFont(for: .button)))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.vertical)
                        .background{
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.theme.spLightBlue), Color(UIColor.theme.spDarkBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                
                    
                })
            }
        }
        
        
//        .navigationBarBackButtonHidden(isPresented)
        .onAppear {
            DataManager.shared.fetchData(target: .classInfo)
            DataManager.shared.fetchData(target: .schedule)
            DataManager.shared.fetchData(target: .members)
            
            if selectedClass == nil {
                selectedClass = DataManager.shared.classInfo?[3]
            }
            classSchedules = DataManager.shared.getSchedules(classInfo: selectedClass!)
            members = DataManager.shared.getMembers(classInfo: selectedClass!)
            classTitle = selectedClass?.name ?? ""
            //텍스트 에디터의 백그라운드를 커스텀 하기 위함
            UITextView.appearance().backgroundColor = .clear
            let someThing = DataManager.shared.fetchSchedules(section: .next)
            if !someThing.isEmpty {
                nextSchedule = someThing[0]
            }
            
          
        }
        .onChange(of: isChanged) { _ in
            classSchedules = DataManager.shared.getSchedules(classInfo: selectedClass!)
        }
        .onChange(of: classSchedules) { _ in
//            print("Change")
            
        }
        .onDisappear{
            dismissAction()
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


struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

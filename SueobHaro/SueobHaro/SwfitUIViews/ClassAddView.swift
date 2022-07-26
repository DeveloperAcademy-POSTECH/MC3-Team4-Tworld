//
//  ClassAddView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/26.
//

import SwiftUI

struct ClassAddView: View {
    @State var viewMode: AddViewMode = .name
    @State var navBarHidden: Bool = true
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
    @State var memberNames: [String] = [""]
    @State var memberPhoneNumbers: [String] = [""]
    @State var tuition: String = ""
    @State var tuitionPer: String = ""
    @State var tuitionPageDone: Bool = false
    
    var dismissAction: (() -> Void)
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                if viewMode != .check {
                    VStack(alignment: .leading, spacing: CGFloat.padding.toComponents) {
                        HStack(spacing: 0) {
                            Button(action: {
                                if viewMode == .name {
                                    navBarHidden = false
                                    dismissAction()
                                } else {
                                    viewMode = viewMode.previousMode
                                }
                            }, label: {
                                HStack(spacing: 0) {
                                    Image(systemName: "chevron.backward")
                                        .font(.headline)
                                        .foregroundColor(.spLightBlue)
                                    Text(" 뒤로 가기")
                                        .font(.body)
                                        .foregroundColor(.spLightBlue)
                                }
                            })
                            .padding([.top, .leading], 8)
                            Spacer()
                        }
                        HStack(spacing: 0) {
                            Text(viewMode.title ?? "")
                                .font(Font(uiFont: .systemFont(for: .title1)))
                                .foregroundColor(.greyscale1)
                                .padding(.top, CGFloat.padding.toComponents)
                                .padding(.horizontal, CGFloat.padding.margin)
                            Spacer()
                        }
                        Rectangle()
                            .foregroundColor(.spLightBlue)
                            .frame(width: tuitionPageDone ? UIScreen.main.bounds.width : viewMode.progressBarWidth, height: CGFloat(3), alignment: .leading)
                    }
                }
                Spacer()
                switch viewMode {
                case .name:
                    ClassNameView(viewMode: $viewMode, className: $className, firstClassDate: $firstClassDate, isDayPicked: $isDayPicked, classTimeInfo: $classTimeInfo)
                case .members:
                    ClassMembersView(viewMode: $viewMode, memberNames: $memberNames, memberPhoneNumbers: $memberPhoneNumbers)
                case .tuition:
                    ClassTuitionView(viewMode: $viewMode, tuition: $tuition, tuitionPer: $tuitionPer, tuitionPageDone: $tuitionPageDone)
                case .check:
                    ClassCheckView(className: $className, firstClassDate: $firstClassDate, isDayPicked: $isDayPicked, classTimeInfo: $classTimeInfo, memberNames: $memberNames, memberPhoneNumbers: $memberPhoneNumbers, tuition: $tuition, tuitionPer: $tuitionPer, dismissAction: dismissAction)
                }
                
            }
        }
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(true)
    }
}

enum AddViewMode {
    case name
    case members
    case tuition
    case check
    
    var title: String? {
        switch self {
        case .name:
            return "수업 추가하기"
        case .members:
            return "학생 등록하기"
        case .tuition:
            return "수업료 입력하기"
        case .check:
            return nil
        }
    }
    
    var progressBarWidth: CGFloat {
        switch self {
        case .name:
            return UIScreen.main.bounds.width/3
        case .members:
            return UIScreen.main.bounds.width*2/3
        case .tuition:
            return UIScreen.main.bounds.width*2.8/3
        case .check:
            return UIScreen.main.bounds.width
        }
    }
    
    var previousMode: AddViewMode {
        switch self {
        case .name:
            return .name
        case .members:
            return .name
        case .tuition:
            return .members
        case .check:
            return .tuition
        }
    }
}

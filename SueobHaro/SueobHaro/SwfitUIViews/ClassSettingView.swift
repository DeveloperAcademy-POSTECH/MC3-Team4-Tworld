//
//  ClassSettingView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/29.
//

import SwiftUI

struct ClassSettingView: View {
    @AppStorage("monthCalendarFirst") var monthCalendarFirst: Bool = false
    @State private var classNoti: Bool = false
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("설정")
                        .font(Font(uiFont: .systemFont(for: .title1)))
                        .foregroundColor(.greyscale1)
                    Spacer()
                }
                .padding(.leading, .padding.margin)
                .padding(.top, .padding.toComponents)
                .padding(.bottom, .padding.toTextComponents)
                
                Button(action: {
                    monthCalendarFirst.toggle()
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(Color.greyscale7)
                        Rectangle()
                            .strokeBorder(Color.greyscale6)
                        Toggle(isOn: $monthCalendarFirst, label: {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("월간달력부터 보여주기")
                                        .font(Font(uiFont: .systemFont(for: .body1)))
                                        .foregroundColor(.greyscale1)
                                        .padding(.bottom, .padding.toText)
                                    Text("모든일정에서 월간달력을 주간달력보다\na먼저 확인할 수 있습니다.")
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(Font(uiFont: .systemFont(for: .caption)))
                                        .foregroundColor(.greyscale3)
                                }
                                Spacer()
                            }
                        })
                        .toggleStyle(SwitchToggleStyle(tint: .spLightBlue))
                        .padding(.vertical, .padding.inBox)
                        .padding(.horizontal, .padding.margin)
                    }.frame(maxHeight: 100)
                })
                Button(action: {
                    classNoti.toggle()
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(Color.greyscale7)
                        Rectangle()
                            .strokeBorder(Color.greyscale6)
                        Toggle(isOn: $classNoti, label: {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("수업 리마인드 알림 설정하기")
                                        .font(Font(uiFont: .systemFont(for: .body1)))
                                        .foregroundColor(.greyscale1)
                                        .padding(.bottom, .padding.toText)
                                    Text("하루 전, 수업 리마인드 알림을 노티를 통해\n확인할 수 있습니다.")
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(Font(uiFont: .systemFont(for: .caption)))
                                        .foregroundColor(.greyscale3)
                                }
                                Spacer()
                            }
                        })
                        .toggleStyle(SwitchToggleStyle(tint: .spLightBlue))
                        .padding(.vertical, .padding.inBox)
                        .padding(.horizontal, .padding.margin)
                        
                    }.frame(maxHeight: 100)
                }).padding(.bottom, .padding.toText)
                
                ZStack {
                    Rectangle()
                        .fill(Color.greyscale7)
                    Rectangle()
                        .strokeBorder(Color.greyscale6)
                    HStack(spacing: 0) {
                        Text("앱 버전 정보")
                            .font(Font(uiFont: .systemFont(for: .body1)))
                            .foregroundColor(.greyscale1)
                        Spacer()
                        Text("1.0")
                            .font(Font(uiFont: .systemFont(for: .body1)))
                            .foregroundColor(.greyscale3)
                    }
                    .padding(.vertical, .padding.inBox)
                    .padding(.horizontal, .padding.margin)
                    
                }.frame(maxHeight: 56)
                Spacer()
            }
        }
    }
}

struct ClassSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ClassSettingView()
    }
}

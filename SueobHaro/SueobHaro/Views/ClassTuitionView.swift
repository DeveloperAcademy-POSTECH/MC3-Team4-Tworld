//
//  ClassTuitionView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/19.
//

import SwiftUI

struct ClassTuitionView: View {
    @Binding var className: String
    @Binding var firstClassDate: Date
    @Binding var isDayPicked: [String:Bool]
    @Binding var classTimeInfo: [String:[String:Date?]]
    @Binding var memberNames: [String]
    @Binding var memberPhoneNumbers: [String]
    
    @State var tuition: String = ""
    @State var tuitionPer: String = ""
    
    @FocusState private var isTuitionFocused: Bool
    @FocusState private var isTuitionPerFocused: Bool
    
    private func isDone() -> Bool {
        guard !tuition.isEmpty && !tuitionPer.isEmpty else {return false}
        return true
    }
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: CGFloat.padding.toComponents) {
                    HStack(spacing: 0) {
                        Text("수업료 입력하기")
                            .font(Font(uiFont: .systemFont(for: .title1)))
                            .foregroundColor(.greyscale1)
                            .padding(.top, CGFloat.padding.toComponents)
                            .padding(.horizontal, CGFloat.padding.margin)
                        Spacer()
                    }
                    Rectangle()
                        .foregroundColor(.spLightBlue)
                        .frame(width: UIScreen.main.bounds.width*2.8/3, height: CGFloat(3), alignment: .leading)
                }
                Text("수업료는 몇 회차마다 받나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.bottom, CGFloat.padding.toText)
                ZStack {
                    VStack(spacing: 4) {
                        TextField("", text: $tuitionPer)
                            .placeholder(when: tuitionPer.isEmpty) {
                                Text("회차를 입력하세요")
                                    .foregroundColor(.greyscale4)
                                    .font(Font(uiFont: .systemFont(for: .body2)))
                            }
                            .keyboardType(.numberPad)
                            .focused($isTuitionPerFocused)
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.margin)
                        Rectangle()
                            .foregroundColor(isTuitionPerFocused ? .spLightBlue : (tuitionPer.isEmpty ? .greyscale4 : .greyscale1))
                            .frame(height: CGFloat(1))
                            .padding(.horizontal, CGFloat.padding.margin)
                    }
                    HStack(spacing: 0) {
                        Spacer()
                        Button(action: {
                            tuitionPer = ""
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.greyscale3)
                                .padding(.trailing, CGFloat.padding.margin)
                                .padding(.bottom, 2)
                        })
                    }
                }
                Text("수업료는 얼마씩 받나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.bottom, CGFloat.padding.toText)
                ZStack {
                    VStack(spacing: 4) {
                        TextField("", text: $tuition)
                            .placeholder(when: tuition.isEmpty) {
                                Text("수업료를 입력하세요")
                                    .foregroundColor(.greyscale4)
                                    .font(Font(uiFont: .systemFont(for: .body2)))
                            }
                            .keyboardType(.numberPad)
                            .focused($isTuitionFocused)
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.margin)
                        Rectangle()
                            .foregroundColor(isTuitionFocused ? .spLightBlue : (tuition.isEmpty ? .greyscale4 : .greyscale1))
                            .frame(height: CGFloat(1))
                            .padding(.horizontal, CGFloat.padding.margin)
                    }
                    HStack(spacing: 0) {
                        Spacer()
                        Button(action: {
                            tuition = ""
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.greyscale3)
                                .padding(.trailing, CGFloat.padding.margin)
                                .padding(.bottom, 2)
                        })
                    }
                }
                Spacer()
                if !isTuitionFocused && !isTuitionPerFocused {
                    if !tuition.isEmpty && !tuitionPer.isEmpty {
                        HStack(spacing: 0) {
                            Spacer()
                            Text("\(tuitionPer)회마다 총 \(tuition)원을 받아요")
                                .font(Font(uiFont: .systemFont(for: .title3)))
                                .foregroundColor(.greyscale1)
                                .padding(.bottom, CGFloat.padding.toComponents)
                            Spacer()
                        }
                    }
                    NavigationLink(destination: {
                        ClassCheckView(className: $className, firstClassDate: $firstClassDate, isDayPicked: $isDayPicked, classTimeInfo: $classTimeInfo, memberNames: $memberNames, memberPhoneNumbers: $memberPhoneNumbers, tuition: $tuition, tuitionPer: $tuitionPer)
                    }, label: {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(isDone() ? .clear : .greyscale4)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.spLightBlue, Color.spDarkBlue]), startPoint: .trailing, endPoint: .leading))
                                .cornerRadius(10)
                            Text("저장하기")
                                .font(Font(uiFont: .systemFont(for: .button)))
                                .foregroundColor(.greyscale1)
                        }
                        .frame(maxHeight: 52)
                    })
                    .padding(.horizontal, CGFloat.padding.margin)
                    .padding(.bottom, CGFloat.padding.toComponents)
                    .disabled(!isDone())
                }
            }
        }
        .onTapGesture {
            isTuitionFocused = false
            isTuitionPerFocused = false
        }
    }
}

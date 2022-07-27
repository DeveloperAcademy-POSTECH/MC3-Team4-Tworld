//
//  ClassTuitionView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/19.
//

import SwiftUI

struct ClassTuitionView: View {
    @Binding var viewMode: AddViewMode
    @Binding var tuition: String
    @Binding var tuitionPer: String
    @Binding var tuitionPageDone: Bool
    
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
                Text("수업료는 몇 회차마다 받나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.bottom, CGFloat.padding.toText)
                ClassTextField(content: $tuitionPer, isFocused: $isTuitionPerFocused, testFieldName: "회차를 입력하세요.")
                Text("수업료는 얼마씩 받나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.bottom, CGFloat.padding.toText)
                ClassTextField(content: $tuition, isFocused: $isTuitionFocused, testFieldName: "수업료를 입력하세요.")
                Spacer()
                if !isTuitionFocused && !isTuitionPerFocused {
                    if !tuition.isEmpty && !tuitionPer.isEmpty {
                        HStack(spacing: 0) {
                            Spacer()
                            Text("\(tuitionPer)회마다 총 \(tuition)원을 받아요")
                                .font(Font(uiFont: .systemFont(for: .title3)))
                                .foregroundColor(.greyscale1)
                                .padding(.bottom, CGFloat.padding.toComponents)
                                .onAppear {
                                    withAnimation(.spring()) {
                                        tuitionPageDone = true
                                    }
                                }
                                .onDisappear {
                                    withAnimation(.spring()) {
                                        tuitionPageDone = false
                                    }
                                }
                            Spacer()
                        }
                    }
                    Button(action: {
                        withAnimation(.spring()) {
                            viewMode = .check
                        }
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

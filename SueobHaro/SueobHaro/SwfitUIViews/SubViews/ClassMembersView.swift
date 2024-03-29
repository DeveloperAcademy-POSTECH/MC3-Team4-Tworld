//
//  ClassMembersView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/19.
//

import SwiftUI
import Combine

struct ClassMembersView: View {
    @Binding var viewMode: AddViewMode
    @Binding var memberNames: [String]
    @Binding var memberSchools: [String]
    @Binding var memberPhoneNumbers: [String]
    @State var currentIdx: Int? = nil
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isScoolFocused: Bool
    @FocusState private var isPhoneNumberFocused: Bool
    
    private func isDone() -> Bool {
        guard !memberNames.isEmpty && !memberPhoneNumbers.isEmpty && !memberSchools.isEmpty else {return false}
        for idx in 0..<memberNames.count {
            if memberNames[idx].isEmpty {
                return false
            }
        }
        return true
    }
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                Text("참여자 정보를 입력해주세요")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.margin)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                ScrollView {
                    LazyVStack(spacing: CGFloat.padding.toComponents) {
                        ForEach(memberNames.indices, id: \.self) { idx in
                            ZStack {
                                VStack(spacing: 0) {
                                    HStack(spacing: 0) {
                                        TextField("", text: $memberNames[idx])
                                            .placeholder(when: memberNames[idx].isEmpty) {
                                                Text("이름")
                                                    .foregroundColor(.greyscale4)
                                                    .font(Font(uiFont: .systemFont(for: .title3)))
                                            }
                                            .focused($isNameFocused)
                                            .font(Font(uiFont: .systemFont(for: .title3)))
                                            .foregroundColor(.greyscale1)
                                            .onReceive(Just(memberNames[idx]), perform: { _ in
                                                if 3 < memberNames[idx].count {
                                                    memberNames[idx] = String(memberNames[idx].prefix(3))
                                                }
                                            })
                                        Spacer()
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                            .font(Font(uiFont: .systemFont(for: .body2)))
                                            .onTapGesture {
                                                memberNames.remove(at: idx)
                                                memberSchools.remove(at: idx)
                                                memberPhoneNumbers.remove(at: idx)
                                            }
                                    }
                                    .padding(.bottom, .padding.toTextComponents)
                                    TextField("", text: $memberSchools[idx])
                                        .placeholder(when: memberSchools[idx].isEmpty) {
                                            Text("학교를 입력해주세요. (선택)")
                                                .foregroundColor(.greyscale4)
                                                .font(Font(uiFont: .systemFont(for: .body2)))
                                        }
                                        .focused($isScoolFocused)
                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                        .foregroundColor(.greyscale1)
                                        .onReceive(Just(memberSchools[idx]), perform: { _ in
                                            if 11 < memberSchools[idx].count {
                                                memberSchools[idx] = String(memberSchools[idx].prefix(11))
                                            }
                                        })
                                        .padding(.bottom, .padding.toText)
                                    TextField("", text: $memberPhoneNumbers[idx])
                                        .placeholder(when: memberPhoneNumbers[idx].isEmpty) {
                                            Text("번호를 입력해주세요. (선택)")
                                                .foregroundColor(.greyscale4)
                                                .font(Font(uiFont: .systemFont(for: .body2)))
                                        }
                                        .focused($isPhoneNumberFocused)
                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                        .foregroundColor(.greyscale1)
                                        .keyboardType(.numberPad)
                                        .onReceive(Just(memberPhoneNumbers[idx]), perform: { _ in
                                            if 11 < memberPhoneNumbers[idx].count {
                                                memberPhoneNumbers[idx] = String(memberPhoneNumbers[idx].prefix(11))
                                            }
                                        })
                                }
                                .padding(CGFloat.padding.inBox)
                                .background(
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.greyscale7)
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(currentIdx == idx ? Color.spLightBlue : ((memberNames[idx].isEmpty || memberPhoneNumbers[idx].isEmpty || memberSchools[idx].isEmpty) ? Color.greyscale5 : Color.greyscale1), lineWidth: 1)
                                    }
                                )
                            }
                            .onTapGesture{
                                currentIdx = idx
                            }
                        }
                        Button(action: {
                            memberNames.append("")
                            memberSchools.append("")
                            memberPhoneNumbers.append("")
                        }, label: {
                            ZStack {
                                HStack(spacing: 0) {
                                    Text("+ 새로운 참여자 추가하기")
                                        .font(Font(uiFont: .systemFont(for: .body1)))
                                        .foregroundColor(.spLightBlue)
                                    Spacer()
                                }
                                .padding(CGFloat.padding.inBox)
                                .background(
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.greyscale7)
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(Color.greyscale5, lineWidth: 1)
                                    }
                                )
                            }
                        })
                    }
                }
                .padding(.top, CGFloat.padding.toTextComponents)
                .padding(.horizontal, CGFloat.padding.margin)
                if !isNameFocused && !isPhoneNumberFocused && !isScoolFocused {
                    Button(action: {
                        withAnimation(.spring()) {
                            viewMode = .tuition
                        }
                    }, label: {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(isDone() ? .spDarkBlue : .greyscale4)
                            Text("다음")
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
        }.onTapGesture {
            isNameFocused = false
            isScoolFocused = false
            isPhoneNumberFocused = false
            currentIdx = nil
        }
    }

}

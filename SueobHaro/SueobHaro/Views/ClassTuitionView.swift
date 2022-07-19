//
//  ClassTuitionView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/19.
//

import SwiftUI

struct ClassTuitionView: View {
    @State var tuition: String = ""
    @State var tuitionPer: String = ""
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: CGFloat.padding.toComponents) {
                    HStack {
                        Text("수업료 입력하기")
                            .font(Font(uiFont: .systemFont(for: .title1)))
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.margin)
                            .padding(.top, CGFloat.padding.toComponents)
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
                    .padding(.leading, CGFloat.padding.toBox)
                ZStack {
                    VStack(spacing: 4) {
                        TextField("", text: $tuition)
                            .placeholder(when: tuition.isEmpty) {
                                Text("회차를 입력하세요")
                                    .foregroundColor(.greyscale3)
                                    .font(Font(uiFont: .systemFont(for: .body2)))
                            }
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.toBox)
                        Rectangle()
                            .foregroundColor(.greyscale3)
                            .frame(height: CGFloat(1))
                            .padding(.horizontal, CGFloat.padding.toBox)
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            tuition = ""
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.greyscale3)
                                .padding(.trailing, CGFloat.padding.toBox)
                                .padding(.bottom, 2)
                        })
                    }
                }
                Text("수업료는 얼마씩 받나요?")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                    .padding(.leading, CGFloat.padding.toBox)
                ZStack {
                    VStack(spacing: 4) {
                        TextField("", text: $tuitionPer)
                            .placeholder(when: tuitionPer.isEmpty) {
                                Text("수업료를 입력하세요")
                                    .foregroundColor(.greyscale3)
                                    .font(Font(uiFont: .systemFont(for: .body2)))
                            }
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.toBox)
                        Rectangle()
                            .foregroundColor(.greyscale3)
                            .frame(height: CGFloat(1))
                            .padding(.horizontal, CGFloat.padding.toBox)
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            tuitionPer = ""
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.greyscale3)
                                .padding(.trailing, CGFloat.padding.toBox)
                                .padding(.bottom, 2)
                        })
                    }
                }
                Spacer()
                NavigationLink(destination: {
                    ClassCheckView()
                }, label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.spDarkBlue)
                        Text("다음")
                            .font(Font(uiFont: .systemFont(for: .button)))
                            .foregroundColor(.greyscale1)
                    }
                    .padding(.horizontal, CGFloat.padding.margin)
                    .frame(maxHeight: 52)
                })
                .padding(.bottom, CGFloat.padding.toComponents)
            }
        }
    }
}

struct ClassTuitionView_Previews: PreviewProvider {
    static var previews: some View {
        ClassTuitionView()
    }
}

//
//  ClassTextField.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/26.
//

import SwiftUI

struct ClassTextField: View {
    @Binding var content: String
    
    var isFocused: FocusState<Bool>.Binding
    var testFieldName: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                TextField("", text: $content)
                    .placeholder(when: content.isEmpty) {
                        Text("수업명을 입력하세요")
                            .foregroundColor(.greyscale4)
                            .font(Font(uiFont: .systemFont(for: .body2)))
                    }
                    .focused(isFocused)
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.margin)
                Rectangle()
                    .foregroundColor(isFocused.wrappedValue ? .spLightBlue : (content.isEmpty ? .greyscale4 : .greyscale1))
                    .frame(height: CGFloat(1))
                    .padding(.horizontal, CGFloat.padding.margin)
            }
            HStack(spacing: 0) {
                Spacer()
                Button(action: {
                    content = ""
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.greyscale3)
                        .padding(.trailing, CGFloat.padding.margin)
                        .padding(.bottom, 2)
                })
            }
        }
    }
}

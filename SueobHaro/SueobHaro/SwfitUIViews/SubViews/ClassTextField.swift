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
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                TextField("", text: $content)
                    .placeholder(when: content.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(.greyscale4)
                            .font(Font(uiFont: .systemFont(for: .body2)))
                    }
                    .focused(isFocused)
                    .font(Font(uiFont: .systemFont(for: .body2)))
                    .foregroundColor(.greyscale1)
                    .keyboardType(keyboardType)
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

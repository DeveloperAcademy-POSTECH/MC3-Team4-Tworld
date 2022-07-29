//
//  ClassUpdateView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/29.
//

import SwiftUI

struct ClassUpdateView: View {
    
    @Binding var classInfo: ClassInfo?

    
    var body: some View {
        ScrollView() {
            Text("수업명")
                .font(Font(uiFont: .systemFont(for: .title3)))
                .foregroundColor(Color.greyscale1)
                .padding(.bottom, CGFloat.padding.toTextComponents)
            
//            Text(classInfo.name ?? "")
//                .font(Font(uiFont: .systemFont(for: .body2)))
//                .foregroundColor(Color.greyscale1)
//                .padding(.bottom, CGFloat.padding.toDifferentHierarchy)
//
//
//            HStack(spacing: 0) {
//                DatePickerView(date: $firstClassDate)
//                Text("부터 수업을 진행해요.")
//                    .font(Font(uiFont: .systemFont(for: .body2)))
//                    .foregroundColor(.greyscale1)
//                Spacer()
//            }
//            .padding(.leading, CGFloat.padding.margin)
//            .padding(.top, CGFloat.padding.inBox)
//        }
        }
    }
        
        
}


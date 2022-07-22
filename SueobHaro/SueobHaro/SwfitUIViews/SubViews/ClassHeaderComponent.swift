//
//  ClassHeader.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/20.
//

import SwiftUI

struct ClassHeaderComponent: View {
    
    @Binding var classInfo:ClassInfo?
    @Binding var memberList: [Members]
    
    var body: some View {
        VStack(spacing: 0) {
            Text(classInfo?.name ?? "")
                .font(Font(uiFont: .systemFont(for: .title2)))
                .foregroundColor(Color(UIColor.theme.greyscale1))
                .padding(.top, CGFloat.padding.inBox)
                .padding(.bottom, CGFloat.padding.toText)
            HStack(spacing: 0) {
                if memberList.count > 0 {
                    ForEach(0..<memberList.count, id: \.self) { i in
                        Text(memberList[i].name ?? "")
                            .font(Font(uiFont: .systemFont(for: .body1)))
                            .foregroundColor(Color(UIColor.theme.greyscale3))
                        if i != memberList.count - 1 {
                            Text(", ")
                                .font(Font(uiFont: .systemFont(for: .body1)))
                                .foregroundColor(Color(UIColor.theme.greyscale3))
                        }
                        
                    }
                }
            }
            .padding(.top, 0)
            .padding(.bottom, CGFloat.padding.inBox)
        }
        .frame(width: UIScreen.main.bounds.size.width - 32)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(UIColor.theme.greyscale7))
                .frame(width: UIScreen.main.bounds.size.width - 32, height: 92)
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.theme.spTurkeyBlue), lineWidth: 1)
                .frame(width: UIScreen.main.bounds.size.width - 32, height: 92)
        }
        
    }
}

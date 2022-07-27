//
//  ClassInformationSheduleComponent.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/21.
//

import SwiftUI

struct ClassInformationListComponent: View {
    let firstText: String
    let secondText: String
    
    var body: some View {
        HStack(spacing: CGFloat.padding.inBox) {
            Text(firstText)
                .font(Font(uiFont: .systemFont(for: .title3)))
                .foregroundColor(Color.greyscale1)
                .frame(width: 45)
            Text(secondText)
                .font(Font(uiFont: .systemFont(for: .body2)))
                .foregroundColor(Color.greyscale1)
            Spacer()
        }
        .padding(.horizontal, CGFloat.padding.inBox)
    }
}

//
//  ClassTitleProgressView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/27.
//

import SwiftUI

struct ClassTitleProgressView: View {
    let title: String
    let progressBarWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: .padding.toComponents) {
            HStack(spacing: 0) {
                Text(title)
                    .font(Font(uiFont: .systemFont(for: .title1)))
                    .foregroundColor(.greyscale1)
                    .padding(.top, CGFloat.padding.toComponents)
                    .padding(.horizontal, CGFloat.padding.margin)
                Spacer()
            }
            Rectangle()
                .foregroundColor(.spLightBlue)
                .frame(width: progressBarWidth, height: CGFloat(3), alignment: .leading)
        }
    }
}

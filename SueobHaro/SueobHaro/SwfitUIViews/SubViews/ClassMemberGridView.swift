//
//  ClassInformationGridView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/28.
//

import SwiftUI

struct ClassMemberGridView: View {
    let memberNames: [String]
    let memberSchools: [String]
    let memberPhoneNumbers: [String]
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var backgroundColor: Color = .spBlack
    @State var strokeColor: Color = .greyscale6
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: .padding.toComponents) {
            ForEach(memberNames.indices, id: \.self) { idx in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(backgroundColor)
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(strokeColor, lineWidth: 1)
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(memberNames[idx])
                                .font(Font(uiFont: .systemFont(for: .title3)))
                                .foregroundColor(Color.greyscale1)
                                .padding(.bottom, .padding.toText)
                            Text(memberSchools[idx])
                                .font(Font(uiFont: .systemFont(for: .body1)))
                                .foregroundColor(Color.greyscale3)
                            Text(memberPhoneNumbers[idx])
                                .font(Font(uiFont: .systemFont(for: .body1)))
                                .foregroundColor(Color.greyscale3)
                        }
                        Spacer()
                    }.padding(.padding.inBox)
                }
            }
        }
    }
}


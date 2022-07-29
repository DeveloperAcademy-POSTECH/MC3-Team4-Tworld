//
//  NavBarBackButton.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/27.
//

import SwiftUI

struct NavBarBackButton: View {
    let title: String
    
    var body: some View {
        Label {
            Text(title)
                .font(.body)
                .foregroundColor(.spLightBlue)
                .padding(-5)
        } icon: {
            Image(systemName: "chevron.backward")
                .font(.headline)
                .foregroundColor(.spLightBlue)
        }
    }
}



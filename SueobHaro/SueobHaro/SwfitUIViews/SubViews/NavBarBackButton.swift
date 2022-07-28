//
//  NavBarBackButton.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/27.
//

import SwiftUI

struct NavBarBackButton: View {
    var body: some View {
        Label {
            Text("뒤로 가기")
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

struct NavBarBackButton_Previews: PreviewProvider {
    static var previews: some View {
        NavBarBackButton()
    }
}

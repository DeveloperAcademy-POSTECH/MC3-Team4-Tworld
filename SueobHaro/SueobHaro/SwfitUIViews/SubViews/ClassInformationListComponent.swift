//
//  ClassInformationSheduleComponent.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/21.
//

import SwiftUI

struct ClassInformationListComponent: View {
    @State var firstText:String = "수"
    @State var secondText:String = "13:00-15:00"
    var body: some View {
        HStack(spacing: 0) {
            Text(firstText)
                .font(.title3)
                .foregroundColor(Color(UIColor.theme.greyscale1))
                .padding(.trailing, CGFloat.padding.inBox)
            Text(secondText)
                .font(.body)
                .foregroundColor(Color(UIColor.theme.greyscale1))
            Spacer()
        }
        .padding(.vertical, CGFloat.padding.inBox)
        .padding(.leading, CGFloat.padding.inBox)
    }
}

struct ClassInformationSheduleComponent_Previews: PreviewProvider {
    static var previews: some View {
        ClassInformationListComponent()
    }
}

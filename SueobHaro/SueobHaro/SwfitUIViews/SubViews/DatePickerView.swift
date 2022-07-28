//
//  DatePickerView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/27.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    
    var body: some View {
        DatePicker("", selection: $date, in: Date()..., displayedComponents: .date)
            .changeTextColor(.spLightBlue)
            .labelsHidden()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
    @ViewBuilder func changeTextColor(_ color: Color) -> some View {
        if UITraitCollection.current.userInterfaceStyle == .light {
            self.colorInvert().colorMultiply(color)
        } else {
            self.colorMultiply(color)
        }
    }
}

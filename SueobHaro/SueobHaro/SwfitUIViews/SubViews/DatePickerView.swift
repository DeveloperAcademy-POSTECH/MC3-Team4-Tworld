//
//  DatePickerView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/27.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    @State var calendarId: UUID = UUID()
    var body: some View {
        DatePicker("", selection: $date,
                   in: Calendar.current.date(byAdding: .month, value: -6, to: date)!...,
                   displayedComponents: .date)
            .id(calendarId)
            .changeTextColor(.spLightBlue)
            .labelsHidden()
            .onChange(of: date) { _ in
                calendarId = UUID()
            }
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

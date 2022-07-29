//
//  ScheduleInfoView.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/28.
//

import SwiftUI

struct ScheduleInfoView: View {
    
    var schedule: Schedule
    
    var body: some View {
        VStack(alignment: .leading, spacing: .padding.inBox) {
            VStack(alignment: .leading, spacing: .padding.toText) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color(schedule.classInfo?.color ?? ""))
                        .frame(width: 8, height: 8)
                    
                    Text(schedule.classInfo?.name ?? "")
                        .font(Font(uiFont: .systemFont(for: .title1)))
                    
                    Spacer()
                    
                    Text("\(schedule.count)회차")
                        .font(Font(uiFont: .systemFont(for: .caption)))
                        .foregroundColor(.spBlack)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 6)
                        .background(
                            Capsule()
                                .fill(LinearGradient(colors: [.spLightGradientLeft, .spLightGradientRight], startPoint: .leading, endPoint: .trailing))
                        )
                }
                
                Text("\((schedule.startTime ?? Date()).toString())~\((schedule.endTime ?? Date()).toString())")
                    .font(Font(uiFont: .systemFont(for: .body1)))
                    .foregroundColor(.greyscale3)
                
                let members = schedule.classInfo?.members?.allObjects as? [Members] ?? []
                
                Text(members.reduce(into: ""){ $0 += "\($1.name ?? ""), " }.dropLast(2))
                    .font(Font(uiFont: .systemFont(for: .body1)))
                    .foregroundColor(.greyscale3)
            }
            
            Rectangle()
                .fill(Color.greyscale6)
                .frame(height: 1)
            
            Text(schedule.progress ?? "")
                .font(Font(uiFont: .systemFont(for: .body2)))
        }
        .padding([.vertical, .leading], .padding.inBox)
        .background(
            ZStack {
                Rectangle()
                    .fill(Color.greyscale7)
                    .cornerRadius(radius: 10, corners: [.topLeft, .bottomLeft])
                
                Rectangle()
                    .strokeBorder(Color.spTurkeyBlue)
                    .cornerRadius(radius: 10, corners: [.topLeft, .bottomLeft])
            }
        )
    }
}

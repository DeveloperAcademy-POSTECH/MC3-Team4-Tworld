//
//  WeeklyNumberView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/30.
//

import SwiftUI

struct WeeklyNumberView: View {
    
    @Binding var numbers: [Int]
    @Binding var dayArray: [Date]
    let frameWidt: CGFloat = UIScreen.main
        .bounds.width * 0.13
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numbers.count, id: \.self) { i in
                ZStack {
                    Text("\(dayToString(day: dayArray[i]))")
                        .font(Font(UIFont.systemFont(for: .body1)))
                        .fontWeight(.bold)
                        .foregroundColor(.greyscale1)
                        
                }
                .frame(width: frameWidt)
            }
        }
    }
    
    func dayToString(day: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        //e는 1~7(sun~sat)
        formatter.dateFormat = "d"
        let result = formatter.string(from: day)
        
        return result
    }
}

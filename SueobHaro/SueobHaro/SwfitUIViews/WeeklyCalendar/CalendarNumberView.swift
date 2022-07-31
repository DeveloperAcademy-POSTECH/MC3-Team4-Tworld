//
//  CalendarNumberView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/30.
//

import SwiftUI

struct CalendarNumberView: View {
    
    
    @State var currentColor:Color = .yellow
    @Binding var dayList:[[Int]]
    let width = UIScreen.main.bounds.width
    @State var isScrolled: Bool = true
    @GestureState var gestureOffset: CGFloat = .zero
    @State var offset: CGFloat = .zero
    @State var currentIndex = 1
    @State var days: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    @State var currentDay = 6
    
    @Binding var dayArray:[[Date]]
    @Binding var currentWeekArray: [Date]
    @Binding var indexOffset: Int
    

    
    var body: some View {
        
        ZStack {
            if !dayArray.isEmpty {
                    HStack(spacing:0) {
                        ForEach(0..<7, id: \.self) { i in
                            if forCompareDate(date: dayArray[1][i]) {
                                Group {
                                    Capsule()
                                        .cornerRadius(18)
                                        .frame(width: 48, height: 36)
                                        .foregroundColor(.spTurkeyBlue)
                                        .rotationEffect(.degrees(90))
                                        
                                }
                                .frame(width: width * 0.13, height: 48)
                            } else {
                                Color.clear.frame(width: width * 0.13, height: 48)
                            }
                        }
                    }
                    .offset(x: width*0.03)
            }
            
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    ForEach(days, id: \.self) { i in
                        Text(i)
                            .font(Font(UIFont.systemFont(for: .caption)))
                            .fontWeight(.bold)
                            .foregroundColor(.greyscale3)
                            .frame(width: width * 0.13)
                    }
                }
                .offset(x: width*0.03)
                
                HStack(spacing: 0) {
                    ForEach(dayArray.indices, id: \.self) { i in
                        ZStack {
                            WeeklyNumberView(numbers: $dayList[i], dayArray: $dayArray[i])
                        }
                    }
                }
//                .edgesIgnoringSafeArea(.horizontal)
                .offset(x: width*0.03 + gestureOffset + offset)
                .gesture(
                    DragGesture()
                        .updating($gestureOffset) { dragValue, gestureState, _ in
                            gestureState = dragValue.translation.width
                        }.onEnded { value in
                            
                            if value.translation.width < -100 {
                                offset = value.translation.width
                                indexOffset += 7
                                withAnimation {
                                    offset = width * -1
                                }
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
                                    dayList.append(dayList[2].map{ $0 + 7 })
                                    dayList.removeFirst()
                                    dayArray.append(dateInWeek(date: Date(), offset: indexOffset+7))
                                    dayArray.removeFirst()
                                    offset = .zero
                                    
                                }
                                
                            }
                            if value.translation.width > 100 {
                                offset = value.translation.width
                                indexOffset -= 7
                                withAnimation {
    //                                proxy.scrollTo(currentIndex + 1)
                                    offset = width * 1
                                }
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
                                    dayList.insert(dayList[0].map{ $0 - 7 }, at: 0)
                                    dayList.removeLast()
                                    dayArray.insert(dateInWeek(date: Date(), offset: indexOffset-7), at: 0)
                                    dayArray.removeLast()
                                    offset = .zero
                                }
                            }
                        }
                )
            }
            
        }
    }
    
    func dateInWeek(date:Date, offset: Int) -> [Date] {
        var result: [Date] = []
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        //e는 1~7(sun~sat)
        formatter.dateFormat = "YYYY-MM-dd-HH:mm-e-EEEE"
        let date =  Calendar.current.date(byAdding: .day, value: offset, to: date)!
        let day = formatter.string(from:date)
        print(day)
        let today = day.components(separatedBy: "-")
        guard let interval = Double(today[4]) else{ return []}
        print(interval)
        var startDay = Date(timeInterval:  -(86400 * (interval - 2)), since: formatter.date(from:day)!)
        if interval == 1 {
           startDay = Calendar.current.date(byAdding: .day, value: -6, to: date)!
        } else {
            startDay = Calendar.current.date(byAdding: .day, value: Int(interval) - 2, to: date)!
        }
        for i in 0..<7 {
            result.append(Calendar.current.date(byAdding: .day, value: i, to: startDay)!)
        }

        return result
    }
    
    func forCompareDate(date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.string(from: date)
        let today = formatter.string(from: Date())
        if date == today {
            return true
        } else {
            return false
        }
    }
}

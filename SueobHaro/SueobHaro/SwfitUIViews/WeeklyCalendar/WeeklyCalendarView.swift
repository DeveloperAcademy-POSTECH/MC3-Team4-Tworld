//
//  WeeklyCalendarView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/30.
//

import SwiftUI

struct WeeklyCalendarView: View {
    
    @State var currentColor:Color = .yellow
    //초기 테스트용 변수
    @State var dayList:[[Int]] = [[1,2,3,4,5,6,7], [8,9,10,11,12,13,14], [15,16,17,18,19,20,21]]
    let width = UIScreen.main.bounds.width
    @State var isScrolled: Bool = true
    @GestureState var gestureOffset: CGFloat = .zero
    @State var offset: CGFloat = .zero
    @State var currentIndex = 1
    @State var days: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    @State var currentDay = 6
    //초기 테스트용 변수
    @State var currentWeekDays:[Int] = [8,9,10,11,12,13,14]
    //SampleData
    @State var sampleSchdule: [Int: [[String]]] = [
        1:[["11:00", "14:00"]],
        2:[["18:00", "23:00"]],
        5:[["16:00", "18:00"]],
        8:[["11:00", "14:00"]],
        9:[["14:00", "18:00"]],
        11:[["10:00", "15:00"]],
        12:[["10:20", "15:30"],["18:00", "22:00"]],
        13:[["10:30", "14:50"]],
        20:[["10:00", "15:00"]],
        16:[["10:20", "15:30"],["18:00", "22:00"]],
        18:[["10:30", "14:50"]],
    ]
    @State var defaultHeight: CGFloat = 500
    //달력에 표시해주는 숫자 배열
    @State var dayArray: [[Date]] = []
    //현재 주가 담기는 배열
    @State var currentWeekArray: [Date] = []
    //기능 추가용
    @State var indexOffset: Int = 0
    
    var body: some View {
        VStack(spacing:0) {
            Group {
                HStack {
                    Text("2022년 3월")
                        .font(Font(uiFont: UIFont.systemFont(for: .title2)))
                    Spacer()
                }
                .padding(.horizontal, CGFloat.padding.margin)
                .padding(.vertical, CGFloat.padding.toDifferentHierarchy)
                
                CalendarNumberView(dayList: $dayList, dayArray: $dayArray, currentWeekArray: $currentWeekArray, indexOffset: $indexOffset)
                    .padding(.bottom, CGFloat.padding.toComponents + 10)
                
            }
            //Background 색상 확인 필요
            .background(Color.spBlack.edgesIgnoringSafeArea(.top))
                ZStack {
                    CalendarBackgroundView(height: $defaultHeight)
                    HStack(spacing:0) {
                        Color.clear
                            .frame(width: UIScreen.main.bounds.width * 0.065)
                        //스케쥴 표시
                            ForEach(currentWeekDays, id: \.self) { i in
                                if (sampleSchdule[i] ?? []).isEmpty {
                                    Color.clear.frame(width:(UIScreen.main.bounds.width - UIScreen.main.bounds.width * 0.065) / 7)
                                }
                                ZStack {
                                    ForEach(sampleSchdule[i] ?? [], id: \.self) { x in
                                        let float = timeToValue(first: x[0], second: x[1])
                                        VStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .fill(Color.spBlack)
                                                    .frame(height: float[0])
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(Color.spLightBlue, lineWidth: 1)
                                                    .frame(height: float[0])
                                                VStack {
                                                    Text("코딩영재반")
                                                        .font(Font(UIFont(name: CustomFont.pretendardBold.name, size: 11)!))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.greyscale1)
                                                        .padding(.bottom, CGFloat.padding.toText)
                                                    Text("\(x[0])~\(x[1])")
                                                        .font(Font(UIFont(name: CustomFont.pretendardBold.name, size: 10)!))
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.greyscale1)
                                                    Spacer()
                                                    
                                                }
                                                .padding(10)
                                                .frame(height: float[0])
                                                
                                                
                                            }
                                            .padding(.top, float[1])
                                            Spacer()
                                        }

                                    }
                                }
                                
                            }
                    }
                    .frame(height: defaultHeight)
                    HStack(spacing: 0) {
                        Color.clear
                            .frame(width: UIScreen.main.bounds.width * 0.065)
                        VStack {
                            Rectangle()
                                .fill(Color.spLightBlue)
                                .frame(height: currentTimePadding(date: Date())[0])
                                .frame(maxWidth: .infinity)
                                .padding(.top, currentTimePadding(date: Date())[1])
                            Spacer()
                        }
                        
                    }
            }
            
        }
        .background(Color.greyscale7)
        .onAppear{
            dayArray = [dateInWeek(date: Date(), offset: -7) , dateInWeek(date: Date(), offset: 0), dateInWeek(date: Date(), offset: 7)]
            currentWeekArray = dateInWeek(date: Date(), offset: 0)
        }
        .onChange(of: dayList, perform: { _ in
            currentWeekDays = dayList[1]
            currentWeekArray = dayArray[1]
            print(currentWeekArray)
        })
    
            
    }
    
    //스케쥴 높이와 위치값 반환
    func timeToValue(first: String, second: String) -> [CGFloat] {
        var startPoint: CGFloat = 0
        var endPoint: CGFloat = 0
        var height: CGFloat = 0
        var timeToValue = first.split(separator: ":")[0]
        var minuteToValue = first.split(separator: ":")[1]
        var result = 0
        result = (Int(timeToValue)! - 9) * 60  + Int(minuteToValue)!
        startPoint = CGFloat(result)
        timeToValue = second.split(separator: ":")[0]
        minuteToValue = second.split(separator: ":")[1]
        result = (Int(timeToValue)! - 9) * 60  + Int(minuteToValue)!
        endPoint = CGFloat(result)
        
        height = (endPoint - startPoint) * defaultHeight / 16 / 60
        let startPdding = startPoint * defaultHeight / 16 / 60
        return [height, startPdding]
    }
    //현재시간 표시용
    func currentTimePadding(date: Date) -> [CGFloat] {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let result = formatter.string(from: date)
        let timeToValue = result.split(separator: ":")[0]
        let minuteToValue = result.split(separator: ":")[1]
        var value = 0
        var paddingValue: CGFloat = 0
        var height: CGFloat = 0
        if Int(timeToValue)! >= 9 {
            value = (Int(timeToValue)! - 9) * 60  + Int(minuteToValue)!
            paddingValue = CGFloat(value) * defaultHeight / 16 / 60
            height = 1
        }
        return [height, paddingValue]
    }
    //일주일치 날짜 가져오기
    func dateInWeek(date:Date, offset: Int) -> [Date] {
        var result: [Date] = []
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        //e는 1~7(sun~sat)
        formatter.dateFormat = "YYYY-MM-dd-HH:mm-e-EEEE"
        let date =  Calendar.current.date(byAdding: .day, value: offset, to: date)!
        let day = formatter.string(from:date)
        let today = day.components(separatedBy: "-")
        guard let interval = Double(today[4]) else{ return []}
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
}

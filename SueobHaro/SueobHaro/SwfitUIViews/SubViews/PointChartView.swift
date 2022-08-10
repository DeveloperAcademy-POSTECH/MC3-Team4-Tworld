//
//  PointChartView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/08/01.
//

import SwiftUI

struct PointChartView: View {
    
    @State var cgFloatdata: [CGFloat] = []
    @Binding var data: [Int]
    @Binding var examScore: [ExamScore]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                //frame height
                //frame(y: 0) 에서 아래로 떨어질 높이
                let height:CGFloat = 195
                //frame width
                let width:CGFloat = 90
                // height 비율 계산하기 위해
                let maxPoint = (cgFloatdata.max() ?? 0) + 10
                
                //Path 영역
                let point = cgFloatdata.enumerated().compactMap { item -> CGPoint in
                    // 최대 높이와의 비율
                    let progress = item.element / maxPoint
                    // 높이 계산
                    let pathHeight = progress * height
                    // x좌표 이동
                    // +50 은 데이터 시작 부분 용
                    let pathWidth = width * CGFloat(item.offset) + 50
                    //y 값이 커질 수록 아래 position, 따라서 pathHeight 은 음수로 계산
                    return CGPoint(x: pathWidth, y: -pathHeight + height)
                }
                
                if !point.isEmpty {
                    Path{ path in
                        //초기값 세팅
                        path.move(to: CGPoint(x: 0, y: point[0].y))
                        path.addLine(to: CGPoint(x: 50, y: point[0].y))
                        path.addLines(point)
                    }
                    .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))

                    LinearGradient(gradient: Gradient(colors: [.spTurkeyBlue.opacity(0), .spTurkeyBlue.opacity(0.7), .spLightBlue.opacity(0.75), .spLightBlue.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                        .clipShape(
                            Path{ path in
                                path.move(to: CGPoint(x: 0, y: height))
                                path.addLine(to: CGPoint(x: 0, y: point[0].y))
                                path.addLine(to: CGPoint(x: 50, y: point[0].y))
                                path.addLines(point)
                                path.addLine(to: CGPoint(x: width * CGFloat(examScore.count - 1) + 50, y: height))
                                path.addLine(to: CGPoint(x: 0, y: height))
                            }
                        
                        )
                    
                    Path{ path in
                        for i in point {
                            path.addEllipse(in: CGRect(x: i.x - 4, y: i.y - 4, width: 8, height: 8))
                        }
                    }
                }
                
            }
            
        }
        .onAppear{
            cgFloatdata = examScore.map{ CGFloat( $0.score )}
            print(cgFloatdata.count, "cout")
        }
        .onChange(of: data) { _ in
            cgFloatdata = examScore.map{ CGFloat( $0.score )}
        }
    }
}

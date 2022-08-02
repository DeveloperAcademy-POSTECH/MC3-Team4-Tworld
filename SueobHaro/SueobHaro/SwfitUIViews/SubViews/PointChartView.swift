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
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                
                let height = proxy.size.height
                let width = proxy.size.width / CGFloat(data.count)
                
                let maxPoint = (cgFloatdata.max() ?? 0) + 50
                
                let point = cgFloatdata.enumerated().compactMap { item -> CGPoint in
                    // 최대 높이와의 비율
                    let progress = item.element / maxPoint
                    // 높이 계산
                    let pathHeight = progress * height
                    // x좌표 이동
                    let pathWidth = width * CGFloat(item.offset)
                    return CGPoint(x: pathWidth, y: -pathHeight + height)
                }
                
                Path{ path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLines(point)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))

                LinearGradient(gradient: Gradient(colors: [.spTurkeyBlue.opacity(0), .spTurkeyBlue.opacity(0.7), .spLightBlue.opacity(0.75), .spLightBlue.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                    .clipShape(
                        Path{ path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLines(point)
                            path.addLine(to: CGPoint(x: width * CGFloat(data.count - 1), y: height))
                            path.addLine(to: CGPoint(x: 0, y: height))
                            
                        }
                    
                    )
            }
            
        }
        .onAppear{
            cgFloatdata = data.map{ CGFloat($0) }
        }
        .onChange(of: data) { _ in
            cgFloatdata = data.map{ CGFloat($0) }
        }
    }
}
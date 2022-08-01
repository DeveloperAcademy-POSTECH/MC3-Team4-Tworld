//
//  PointChartView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/08/01.
//

import SwiftUI

struct PointChartView: View {
    
    @State var cgFloatdata: [CGFloat] = []
    @State var data: [Int] = [80, 70, 60, 70, 90, 100, 90, 95]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                let height = proxy.size.height
                let width = proxy.size.width / CGFloat(data.count)
                
                let maxPoint = (cgFloatdata.max() ?? 0) + 50
                
                let point = cgFloatdata.enumerated().compactMap { item -> CGPoint in
                    
                    let progress = item.element / maxPoint
                    let pathHeight = progress * height
                    
                    let pathWidth = width * CGFloat(item.offset)
                    
                    return CGPoint(x: pathWidth, y: -pathHeight + height)
                }
                
                Path{ path in
                    
                    path.move(to: CGPoint(x: 0, y: 0))
                    
                    path.addLines(point)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                
                LinearGradient(gradient: Gradient(colors: [.spTurkeyBlue.opacity(0), .spTurkeyBlue, .spLightBlue, .spLightBlue]), startPoint: .bottom, endPoint: .top)
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
    }
}

struct PointChartView_Previews: PreviewProvider {
    static var previews: some View {
        PointChartView()
    }
}

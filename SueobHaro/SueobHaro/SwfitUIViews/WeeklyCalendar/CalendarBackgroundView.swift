//
//  CalendarBackgroundView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/30.
//

import SwiftUI

struct CalendarBackgroundView: View {
    
    @Binding var height: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                VStack(spacing: 0) {
                    ForEach(9..<25) { i in
                        Rectangle()
                            .stroke(.gray)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }.frame(height: height)
                VStack(spacing: 0) {
                    ForEach(9..<25) { i in
                        HStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.spBlack)
                                    .frame(width: UIScreen.main.bounds.width * 0.065)
                                
                            }
                            Spacer()
                        }
                    }
                }
                .frame(height: height)
                VStack(spacing: 0) {
                    ForEach(9..<25) { i in
                        HStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.spBlack)
                                    .frame(width: UIScreen.main.bounds.width * 0.065)
                                Text("\(i)")
                                    .foregroundColor(.white)
                                
                            }
                            Spacer()
                        }
                    }
                }
                .frame(height: height)
                .offset( y: height * -1 / 32)
                
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(.black)
                        .frame(height: height/16)
                        .offset(y: height/32)
                }
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(.black)
                        .frame(width: 1)
                }
                .onAppear{
//                    height = reader.frame(in: .local).height
//                    print(height)
                }
            }
        }
//        .frame(height: 400)
    }
}


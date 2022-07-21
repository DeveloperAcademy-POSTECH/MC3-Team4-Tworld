//
//  TeamInfoView.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/21.
//

import SwiftUI

struct TeamInfoView: View {
    
    var team: ClassInfo?
    
    var body: some View {
        VStack(spacing: .padding.toDifferentHierarchy) {
            VStack(spacing: .padding.inBox) {
                VStack(spacing: .padding.toText) {
                    Text(team?.name ?? "")
                        .font(Font(uiFont: .systemFont(for: .title2)))
                    Text("샤샤, 에반. 멕스")
                        .font(Font(uiFont: .systemFont(for: .body1)))
                        .foregroundColor(.gray)
                }
                
                customDivier
                
                VStack(spacing: .padding.toText) {
                    Text("\(team?.firstDate?.toString() ?? "") 부터 수업을 진행했어요.")
                        .font(Font(uiFont: .systemFont(for: .body2)))
                    Text("4회마다 총 300,000원 받아요.")
                        .font(Font(uiFont: .systemFont(for: .title3)))
                }
            }
            .foregroundColor(.white)
            .padding(.vertical, .padding.inBox)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color(uiColor: .theme.spTurkeyBlue))
            )
            
            VStack(spacing: .padding.toTextComponents) {
                Text("수업 일정")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    ForEach(0..<3) { i in
                        HStack(spacing: .padding.inBox) {
                            Text("수")
                                .font(Font(uiFont: .systemFont(for: .title3)))
                            Text("13:00~15:00")
                                .font(Font(uiFont: .systemFont(for: .body2)))
                            Spacer()
                        }
                        .padding(.horizontal, .padding.inBox)
                        
                        if i != 2 {
                            customDivier
                        }
                    }
                }
                .padding(.vertical, .padding.inBox)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(uiColor: .theme.greyscale5))
                )
            }
            
            VStack(spacing: .padding.toTextComponents) {
                Text("참여자")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    ForEach(0..<3) { i in
                        HStack(spacing: .padding.inBox) {
                            Text("최세영")
                                .font(Font(uiFont: .systemFont(for: .title3)))
                            Text("010-4444-4444")
                                .font(Font(uiFont: .systemFont(for: .body2)))
                            Spacer()
                        }
                        .padding(.horizontal, .padding.inBox)
                        
                        if i != 2 {
                            customDivier
                        }
                    }
                }
                .padding(.vertical, .padding.inBox)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(uiColor: .theme.greyscale5))
                )
            }
            
            Spacer()
        }
        .padding(.top, .padding.toComponents)
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("hi")
                } label: {
                    Text("편집")
                }
                .tint(Color(uiColor: .theme.spLightBlue))

            }
        }
    }
    
    private var customDivier: some View {
        Rectangle()
            .fill(Color(uiColor: .theme.greyscale6))
            .frame(maxWidth: .infinity)
            .frame(height: 1)
    }
}

struct TeamInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TeamInfoView()
        }
        .preferredColorScheme(.dark)
    }
}


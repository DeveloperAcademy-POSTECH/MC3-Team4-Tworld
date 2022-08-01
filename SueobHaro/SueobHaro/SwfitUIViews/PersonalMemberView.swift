//
//  PersonalMemberView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/08/01.
//

import SwiftUI

struct PersonalMemberView: View {
    
    @State var inputText: String = ""
    
    @State var isShow: Bool = false
    @FocusState var isFocused: Bool
    @State var isShowHalfMOdal: Bool = false
    
    let pointArray = [80, 70, 60, 70, 90, 100, 90, 95]
    let examArray = ["3월", "중간고사", "모의고사", "모의고사", "기말고사", "중간고사", "모의고사", "수능"]
    let pointPerHeight:CGFloat = 195 / 100
    
    @State var examTitle:String = ""
    @State var examPoint:String = ""
    @FocusState var isExamTitleFocused: Bool
    @FocusState var isExamPointFocused: Bool
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: CGFloat.padding.inBox) {
                    HStack(spacing: 0) {
                        Text("사샤")
                            .font(Font(UIFont.systemFont(for: .title2)))
                            .foregroundColor(.greyscale1)
                        Spacer()
                        Circle()
                            .foregroundColor(.mint)
                            .frame(width: 8, height: 8)
                            .padding(.trailing, CGFloat.padding.toText)
                        Text("한국지리 기초반")
                            .font(Font(UIFont.systemFont(for: .body1)))
                            .foregroundColor(.greyscale1)
                    }
                    VStack (spacing:0) {
                        HStack {
                            Text("태장고등학교")
                                .font(Font(UIFont.systemFont(for: .body1)))
                                .foregroundColor(.greyscale3)
                            Spacer()
                        }
                        HStack {
                            Text("010-2014-4586")
                                .font(Font(UIFont.systemFont(for: .body1)))
                                .foregroundColor(.greyscale3)
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, CGFloat.padding.inBox)
                if !isShow {
                    VStack (spacing: 0) {
                        HStack {
                            Text("학업 성취도")
                                .font(Font(UIFont.systemFont(for: .title3)))
                                .foregroundColor(.greyscale1)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    isShowHalfMOdal = true
                                }
                            }, label: {
                                Text("점수 추가하기")
                                    .font(Font(UIFont.systemFont(for: .body1)))
                                    .foregroundColor(.spLightBlue)
                            })
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            ZStack {
                                HStack(spacing: 0) {
                                        ForEach(0..<8) { i in
                                            VStack(spacing: 0) {
                                                ZStack {
                                                    Color.clear
                                                        .frame(width: 90, height: 195)
                                                    Rectangle()
                                                        .stroke()
                                                        .offset(x: 45)
                                                }
                                                .padding(.bottom, CGFloat.padding.toComponents)
                                                Text("\(pointArray[i])")
                                                    .font(.system(size: 14))
                                                    .font(Font(UIFont.systemFont(for: .body1)))
                                                    .foregroundColor(.greyscale1)
                                                    .background(Capsule().fill(Color.greyscale6).cornerRadius(12).frame(width:49, height: 24))
                                                    .padding(.bottom, CGFloat.padding.toText)
                                                Text(examArray[i])
                                                    .font(.system(size: 12))
                                                    .font(Font(UIFont.systemFont(for: .body2)))
                                                    .foregroundColor(.greyscale4)
                                            }
                                            .offset(x: -45)
                                        }
                                }
                                PointChartView()
                                    .offset(y: -50)
                            }
                            
                            
                            
                        }
                        .padding(.top, CGFloat.padding.toTextComponents)
                        .padding(.bottom, CGFloat.padding.toDifferentHierarchy)
            
                        
                    }
                    .padding(.top, CGFloat.padding.inBox)
                    
                    
                }
                
                HStack {
                    Text("특이사항")
                        .font(Font(UIFont.systemFont(for: .title3)))
                        .foregroundColor(.greyscale1)
                    Spacer()
                }
                .padding(.bottom, CGFloat.padding.toComponents)
                if !isShow {
                    VStack(spacing: 10) {
                        Button(action: {
                            withAnimation {
                                isFocused = true
                                isShow = true
                            }
                        }, label: {
                            HStack(spacing:0) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.spLightBlue)
                                    .frame(width: 20, height: 20)
                                Text(" 기록할 내용을 적어주세요")
                                    .foregroundColor(.spLightBlue)
                                    .font(Font(UIFont.systemFont(for: .body2)))
                                Spacer()
                                    
                            }
                            .padding(CGFloat.padding.inBox)
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.greyscale7)
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.greyscale6, lineWidth: 1)
                                
                            }
                        })
                        
                        ForEach(0..<5) { _ in
                            VStack(spacing: CGFloat.padding.toText) {
                                HStack {
                                    Text("2022.7.14 (목)")
                                        .font(.system(size: 16))
                                        .font(Font(UIFont.systemFont(for: .body2)))
                                        .foregroundColor(.greyscale4)
                                    Spacer()
                                    Image(systemName: "trash")
                                        .foregroundColor(.greyscale1)
                                        .frame(width: 18, height: 18)
                                }
                                HStack {
                                    Text("지리에 대한 지식이 아무것도 없다.")
                                        .font(Font(UIFont.systemFont(for: .body2)))
                                        .foregroundColor(.greyscale1)
                                    Spacer()
                                }
                                
                            }
                            .padding(CGFloat.padding.inBox)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.greyscale7)
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.greyscale6, lineWidth: 1)
                            }
                            
                        }
                        
                        
                    }
                }
                
                if isShow {
                    ZStack {
                        TextEditor(text: $inputText)
                            .focused($isFocused)
                            .padding(CGFloat.padding.inBox)
                            .frame(height: UIScreen.main.bounds.height / 3 - 20)
                        if inputText.count == 0 {
                            VStack {
                                HStack {
                                    Text("기록할 내용을 적어주세요")
                                        .font(Font(UIFont.systemFont(for: .body2)))
                                        .foregroundColor(.greyscale4)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding(CGFloat.padding.toTextComponents + 5)
                        }
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.greyscale7)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.spTurkeyBlue, lineWidth: 1)
                    }
                }
               
                
                
                
            }
            .onTapGesture(perform: {
                if isShow || isFocused {
                    isShow = false
                    isFocused = false
                }
            })
            
            halfModal()
        }
        
        .padding(.top, CGFloat.padding.toComponents)
        .padding(.horizontal, CGFloat.padding.margin)
        .background{
            Color.spBlack.ignoresSafeArea()
                
        }
        .toolbar {
            // 키보드에 저장 버튼을 둔다
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: {
                    if isShow {
                        print("특이사항 저장하기")
                        inputText = ""
                        isShow = false
                        isFocused = false
                    } else if (isShowHalfMOdal) {
                        if isExamTitleFocused && !examTitle.isEmpty && examPoint.isEmpty {
                            isExamTitleFocused = false
                            isExamPointFocused = true
                        } else if  (isExamPointFocused) && !examPoint.isEmpty && examTitle.isEmpty {
                            isExamTitleFocused = true
                            isExamPointFocused = false
                        } else if (!examTitle.isEmpty && !examPoint.isEmpty) {
                            print("저장하기")
                            isShowHalfMOdal = false
                            examPoint = ""
                            examTitle = ""
                        }
                    }
                    
                }, label: {
                    if isShow {
                        Text("저장하기")
                            .font(Font(uiFont: .systemFont(for: .button)))
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width)
                            .padding(.vertical)
                            .background{
                                Rectangle()
                                    .fill(LinearGradient(gradient: Gradient(colors: inputText.count == 0 ? [Color.greyscale4] : [Color(UIColor.theme.spLightBlue), Color(UIColor.theme.spDarkBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                    }
                    if isShowHalfMOdal {
                        if (examTitle.isEmpty || examPoint.isEmpty) {
                            Text("다음")
                                .font(Font(uiFont: .systemFont(for: .button)))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width)
                                .padding(.vertical)
                                .background{
                                    if isExamTitleFocused {
                                        Rectangle()
                                            .fill(LinearGradient(gradient: Gradient(colors: examTitle.isEmpty ? [Color.greyscale4] : [Color(UIColor.theme.spLightBlue), Color(UIColor.theme.spDarkBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    } else if isExamPointFocused {
                                        Rectangle()
                                            .fill(LinearGradient(gradient: Gradient(colors: examPoint.isEmpty ? [Color.greyscale4] : [Color(UIColor.theme.spLightBlue), Color(UIColor.theme.spDarkBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    } else {
                                        Rectangle()
                                            .fill(LinearGradient(gradient: Gradient(colors: [Color.greyscale4]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                    
                                }
                            
                        } else {
                            Text("저장하기")
                                .font(Font(uiFont: .systemFont(for: .button)))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width)
                                .padding(.vertical)
                                .background{
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient( colors: [Color(UIColor.theme.spLightBlue), Color(UIColor.theme.spDarkBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                        }
                    }
                    
                })
            }
        }
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
    }
    
    
    @ViewBuilder
    func halfModal() -> some View {
        VStack {
            Color.clear
            VStack(spacing: 0) {
                HStack {
                    Text("어떤 시험인가요?")
                        .font(Font(UIFont.systemFont(for: .button)))
                        .foregroundColor(.greyscale1)
                        .padding(.vertical, CGFloat.padding.inBox)
                    Spacer()
                }
                
                
                ClassTextField(content: $examTitle, isFocused: $isExamTitleFocused, placeholder: "3월 모의고사, 2학기 중간고사.")
                    .padding(.bottom, CGFloat.padding.toDifferentHierarchy)
                HStack {
                    Text("몇 점인가요?")
                        .font(Font(UIFont.systemFont(for: .button)))
                        .foregroundColor(.greyscale1)
                        .padding(.bottom, CGFloat.padding.inBox)
                    Spacer()
                }
                HStack {
                    ClassTextField(content: $examPoint, isFocused: $isExamPointFocused, placeholder: "점수를 입력해주세요.", keyboardType: .numberPad)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .padding(.bottom, CGFloat.padding.toDifferentHierarchy)
                    Spacer()
                }
                
            }
            .background{
                Rectangle()
                    .fill(Color(UIColor.theme.greyscale6))
                    .cornerRadius(radius: 10.0, corners: [.topLeft, .topRight])
                    .frame(width: UIScreen.main.bounds.size.width)
                    .ignoresSafeArea(edges: .bottom)
                    
                    
            }.ignoresSafeArea()
    
        }
        .offset(y: isShowHalfMOdal ? 0 : UIScreen.main.bounds.height)
        .background{
            Color.black.opacity(isShowHalfMOdal ? 0.7 : 0)
                .onTapGesture {
                    withAnimation{
                        isShowHalfMOdal = false
                        isExamPointFocused = false
                        isExamTitleFocused = false
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
        }
    }
}

struct PersonalMemberView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalMemberView()
            .preferredColorScheme(.dark)
    }
}

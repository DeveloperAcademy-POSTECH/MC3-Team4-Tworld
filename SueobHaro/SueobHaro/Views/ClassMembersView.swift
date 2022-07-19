//
//  ClassMembersView.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/19.
//

import SwiftUI

struct ClassMembersView: View {
    @State var members: [[String:String?]] = []
    
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: CGFloat.padding.toComponents) {
                    HStack {
                        Text("참여자 등록하기")
                            .font(Font(uiFont: .systemFont(for: .title1)))
                            .foregroundColor(.greyscale1)
                            .padding(.leading, CGFloat.padding.margin)
                            .padding(.top, CGFloat.padding.toComponents)
                        Spacer()
                    }
                    Rectangle()
                        .foregroundColor(.spLightBlue)
                        .frame(width: UIScreen.main.bounds.width*2/3, height: CGFloat(3), alignment: .leading)
                }
                Text("참여자 정보를 입력해주세요")
                    .font(Font(uiFont: .systemFont(for: .title3)))
                    .foregroundColor(.greyscale1)
                    .padding(.leading, CGFloat.padding.toBox)
                    .padding(.top, CGFloat.padding.toDifferentHierarchy)
                ScrollView {
                    LazyVStack(spacing: CGFloat.padding.toComponents) {
                        ForEach(members, id: \.self) { member in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).frame(maxHeight: CGFloat(60))
                                HStack {
                                    Text(member["name"]! ?? "이름")
                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                        .foregroundColor(member["name"]! == nil ? Color.greyscale3 : Color.greyscale1)
                                    Spacer()
                                    Text(member["phoneNumber"]! ?? "연락처를 입력해주세요.")
                                        .font(Font(uiFont: .systemFont(for: .body2)))
                                        .foregroundColor(member["name"]! == nil ? Color.greyscale3 : Color.greyscale1)
                                }.padding(CGFloat.padding.inBox)
                            }
                        }.onDelete(perform: delete)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).frame(maxHeight: CGFloat(60))
                            HStack {
                                Text("+ 새로운 참여자 추가하기")
                                    .font(Font(uiFont: .systemFont(for: .body1)))
                                    .foregroundColor(.spLightBlue)
                                Spacer()
                            }
                            .padding(CGFloat.padding.inBox)
                            .onTapGesture {
                                members.append(["id": UUID().uuidString, "name": nil, "phoneNumber": nil])
                            }
                        }
                    }
                }
                .padding(.top, CGFloat.padding.toTextComponents)
                .padding(.horizontal, CGFloat.padding.toBox)
                
                NavigationLink(destination: {
                    ClassTuitionView()
                }, label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.spDarkBlue)
                        Text("다음")
                            .font(Font(uiFont: .systemFont(for: .button)))
                            .foregroundColor(.greyscale1)
                    }
                    .padding(.horizontal, CGFloat.padding.margin)
                    .frame(maxHeight: 52)
                })
                .padding(.bottom, CGFloat.padding.toComponents)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        members.remove(atOffsets: offsets)
    }
}

struct ClassMembersView_Previews: PreviewProvider {
    static var previews: some View {
        ClassMembersView()
    }
}

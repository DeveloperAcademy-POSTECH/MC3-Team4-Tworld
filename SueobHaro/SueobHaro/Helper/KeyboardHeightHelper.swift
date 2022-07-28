//
//  KeyboardHeightHelper.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/28.
//

import Foundation
import UIKit


//키보드가 올라올 때 해당 클래스를 이용하면 키보드 높이를 받아올 수 있다.
class UIKeyboardHeightHelper: ObservableObject {
    //키보드 변화에 따라 키보드 높이값을 할당 받는 변수
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        self.keyboardNotification()
    }
    
    private func keyboardNotification() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                guard let userInfo = notification.userInfo,
                                                    let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                                                
                                                self.keyboardHeight = keyboardRect.height
            print("keyboard height\(keyboardRect.height)")
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                self.keyboardHeight = 0
        }
    }
}

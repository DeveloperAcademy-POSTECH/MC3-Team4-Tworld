//
//  DesignGuideline.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/18.
//

import Foundation
import UIKit
import SwiftUI

// MARK: Color
// self.view.backgroundColor = .theme.spLightBlue
extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let spBlack = UIColor(named: "SPBlack")!
    let spDarkBlue = UIColor(named: "SPDarkBlue")!
    let spLightBlue = UIColor(named: "SPLightBlue")!
    let spTurkeyBlue = UIColor(named: "SPTurkeyBlue")!
    
    let greyscale1 = UIColor(named: "Greyscale1")!
    let greyscale2 = UIColor(named: "Greyscale2")!
    let greyscale3 = UIColor(named: "Greyscale3")!
    let greyscale4 = UIColor(named: "Greyscale4")!
    let greyscale5 = UIColor(named: "Greyscale5")!
    let greyscale6 = UIColor(named: "Greyscale6")!
    let greyscale7 = UIColor(named: "Greyscale7")!
}

// MARK: Color for swiftUI
extension Color {
    static let spBlack = Color("SPBlack")
    static let spDarkBlue = Color("SPDarkBlue")
    static let spLightBlue = Color("SPLightBlue")
    static let spTurkeyBlue = Color("SPTurkeyBlue")
    
    static let greyscale1 = Color("Greyscale1")
    static let greyscale2 = Color("Greyscale2")
    static let greyscale3 = Color("Greyscale3")
    static let greyscale4 = Color("Greyscale4")
    static let greyscale5 = Color("Greyscale5")
    static let greyscale6 = Color("Greyscale6")
    static let greyscale7 = Color("Greyscale7")
}

// MARK: Font
// label.font = .systemFont(for: .title1)
extension UIFont {
    static func systemFont(for customStyle: CustomTextStyle) -> UIFont {
        var customFont: UIFont!
        switch customStyle {
        case .title1:
            customFont = UIFont(name: CustomFont.pretendardBold.name, size: 28)!
        case .title2:
            customFont = UIFont(name: CustomFont.pretendardBold.name, size: 24)!
        case .title3:
            customFont = UIFont(name: CustomFont.pretendardBold.name, size: 20)!
        case .body1:
            customFont = UIFont(name: CustomFont.pretendardMedium.name, size: 16)!
        case .body2:
            // 사용 시 UILabel에서 행간 22로 고정
            customFont = UIFont(name: CustomFont.pretendardLight.name, size: 16)!
        case .button:
            customFont = UIFont(name: CustomFont.pretendardBold.name, size: 17)!
        case .caption:
            customFont = UIFont(name: CustomFont.pretendardBold.name, size: 12)!
        }
        return customFont
    }
}

enum CustomFont {
    case pretendardBold
    case pretendardLight
    case pretendardMedium
    
    var name: String {
        switch self {
        case .pretendardBold:
            return "Pretendard-Bold"
        case .pretendardLight:
            return "Pretendard-Light"
        case .pretendardMedium:
            return "Pretendard-Medium"
        }
    }
}

enum CustomTextStyle {
    case title1
    case title2
    case title3
    case body1
    case body2
    case button
    case caption
}

// MARK: Padding
// stackView.layoutMargins = UIEdgeInsets(top: .padding.toComponents, left: 0, bottom: 0, right: 0)
extension CGFloat {
    static let padding = PaddingTheme()
}

struct PaddingTheme {
    let toComponents = CGFloat(12)
    let toText = CGFloat(8)
    let inBox = CGFloat(18)
    let toBox = CGFloat(18)
    let toTextComponents = CGFloat(26)
    let toDifferentHierarchy = CGFloat(36)
}

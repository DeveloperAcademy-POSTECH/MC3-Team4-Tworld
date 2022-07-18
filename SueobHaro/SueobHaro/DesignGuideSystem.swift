//
//  DesignGuideline.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/18.
//

import Foundation
import UIKit

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
            //MARK: 사용 시 UILabel에서 행간 22로 고정
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

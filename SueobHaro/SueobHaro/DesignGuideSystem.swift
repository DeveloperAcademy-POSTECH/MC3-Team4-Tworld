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

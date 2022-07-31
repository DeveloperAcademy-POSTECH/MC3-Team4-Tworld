//
//  MainTabBarController.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/27.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .theme.greyscale5
        appearance.backgroundColor = .theme.spBlack
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .theme.spLightBlue
        self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        let firstNC = UINavigationController(rootViewController: ViewController())
        let secondNC = UIHostingController(rootView: PlanView())
        let thirdNC = UINavigationController.init(rootViewController: UIViewController())
        
        self.viewControllers = [firstNC, secondNC, thirdNC]
        
        let firstTabBarItem = UITabBarItem(title: "빠른수업", image: UIImage(systemName: "list.bullet"), tag: 0)
        let secondTabBarItem = UITabBarItem(title: "모든일정", image: UIImage(systemName: "calendar"), tag: 1)
        let thirtdTabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 2)
        
        firstNC.tabBarItem = firstTabBarItem
        secondNC.tabBarItem = secondTabBarItem
        thirdNC.tabBarItem = thirtdTabBarItem
    }
}

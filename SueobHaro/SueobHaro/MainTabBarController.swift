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
        let thirdNC = UINavigationController(rootViewController: ClassMemberViewController())
        let fourthNC = UIHostingController(rootView: ClassSettingView())
        
        self.viewControllers = [firstNC, secondNC, thirdNC, fourthNC]
        
        let firstTabBarItem = UITabBarItem(title: "빠른수업", image: UIImage(systemName: "list.bullet"), tag: 0)
        firstTabBarItem.image = .planUnselected
        firstTabBarItem.selectedImage = .plan
        let secondTabBarItem = UITabBarItem(title: "모든일정", image: UIImage(systemName: "calendar"), tag: 1)
        secondTabBarItem.image = .calendarUnselected
        secondTabBarItem.selectedImage = .calendar
        let thirtdTabBarItem = UITabBarItem(title: "학생관리", image: UIImage(systemName: "person.text.rectangle"), tag: 2)
        let fourthTabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 3)
        firstNC.tabBarItem = firstTabBarItem
        secondNC.tabBarItem = secondTabBarItem
        thirdNC.tabBarItem = thirtdTabBarItem
        fourthNC.tabBarItem = fourthTabBarItem
    }
}

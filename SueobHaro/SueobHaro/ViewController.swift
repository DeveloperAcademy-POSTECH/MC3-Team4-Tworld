//
//  ViewController.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/16.
//

import UIKit
import CoreData
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard DataManager.shared.container != nil else { fatalError("This view needs a persistent container.") }
        self.navigationController?.pushViewController(UIHostingController(rootView: ClassNameView()), animated: true)
    }
    
}




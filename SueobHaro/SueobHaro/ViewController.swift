//
//  ViewController.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/16.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard container != nil else { fatalError("This view needs a persistent container.") }
        
        
    }


}


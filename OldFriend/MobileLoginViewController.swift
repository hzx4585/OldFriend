//
//  MobileLoginViewController.swift
//  OldFriend
//
//  Created by 黄之信 on 17/3/24.
//  Copyright © 2017年 MichaelHuang. All rights reserved.
//

import UIKit
import TabPageViewController

class MobileLoginViewController: UITableViewController {
    @IBOutlet weak var LoginButton: UIButton!
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    LoginButton.layer.cornerRadius = 3.0
    
    let navigationHeight = topLayoutGuide.length
    tableView.contentInset.top = navigationHeight + TabPageOption().tabHeight
    
        
    }

}

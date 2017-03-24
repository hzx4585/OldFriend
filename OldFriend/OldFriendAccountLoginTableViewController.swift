//
//  OldFriendAccountLoginTableViewController.swift
//  
//
//  Created by 黄之信 on 17/3/23.
//
//

import UIKit
import TabPageViewController

class OldFriendAccountLoginTableViewController: UITableViewController {
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBAction func HideTextFieldButton(_ sender: UIButton) {
        passWord.isSecureTextEntry = !passWord.isSecureTextEntry
    }
    
    override func viewDidLayoutSubviews() {
        passWord.isSecureTextEntry = true
        super.viewDidLayoutSubviews()
        
        let navigationHeight = topLayoutGuide.length
        tableView.contentInset.top = navigationHeight + TabPageOption().tabHeight
        // 这段代码相当于把表格移到合适位置
    }
}

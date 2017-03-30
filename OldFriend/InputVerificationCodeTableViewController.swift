//
//  InputVerificationCodeTableViewController.swift
//  OldFriend
//
//  Created by 黄之信 on 17/3/28.
//  Copyright © 2017年 MichaelHuang. All rights reserved.
//

import UIKit

class InputVerificationCodeTableViewController: UITableViewController {
    @IBOutlet weak var messageLabel: UILabel!
    var Counter = 60
    var Timer = Foundation.Timer()
    var phoneNumber = ""
    let timeButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = "短信验证码已经发送到" + phoneNumber
        Timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.navigationItem.rightBarButtonItem = timeButton
    }
    
    @objc private func updateTime() {
        Counter = Counter - 1
        timeButton.title = String(format: "%d", Counter) + "s后重新发送"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}

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
    private var status = false
    var Counter = 60
    var Timer = Foundation.Timer()
    var phoneNumber = ""
    @IBOutlet weak var timeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        timeButton.isEnabled = false
        timeButton.title = "60s后重新发送"
        messageLabel.text = "短信验证码已经发送到" + phoneNumber
        starTimer()
        self.navigationItem.rightBarButtonItem = timeButton
    }
    
    func starTimer() {
        Timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func recentVerificationCodeButtonTapped(_ sender: UIBarButtonItem) {
        timeButton.title = "60s后重新发送"
        timeButton.isEnabled = false
        Counter = 60
        if (status) {
            sendVerificationCode()
            Timer.invalidate()
            starTimer()
        }
    }

    @objc private func updateTime() {
        if (Counter > 1) {
            Counter = Counter - 1
            timeButton.title = String(format: "%d", Counter) + "s后重新发送"
        }
        else {
            timeButton.title = "重新发送"
            timeButton.isEnabled = true
            status = true
        }
    }
    
    private func checkVerificationCode() -> Bool{
        return true
    }
    
    @IBAction func InputVerificationCodeButtonTapped(_ sender: UIButton) {
        if (checkVerificationCode()) {
            self.performSegue(withIdentifier: "inputVerificationCode", sender: self)
        }
        else {
            let alertController = UIAlertController(title: "",
                                                    message: "请输入正确的验证码", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "知道了", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
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

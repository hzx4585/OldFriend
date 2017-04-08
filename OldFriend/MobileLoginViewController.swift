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
  
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBAction func getVerificationCodeButtonTapped(_ sender: UIButton) {
        if (check(phoneNumber: phoneTextField.text!)){
            let result = mobileLoginSendVerificationCode(phone: phoneTextField.text!)
            if ((result["ret"] as! Int) == -1) {
                if ((result["error"] as! String) == "phone repeat") {
                    let alertController = UIAlertController(title: "",
                                                            message: "手机已经注册过老友账号，请使用账号密码登录", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "知道了", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let result = mobileLogin(phone: phoneTextField.text!, verification: verificationCodeTextField.text!)
        if ((result["ret"] as! Int) == 0) {
            self.performSegue(withIdentifier: "phoneNumberLoginSegue", sender: self)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.isScrollEnabled = false
        LoginButton.layer.cornerRadius = 3.0
        let navigationHeight = topLayoutGuide.length
        tableView.contentInset.top = navigationHeight + TabPageOption().tabHeight
    }
}

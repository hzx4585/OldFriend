//
//  LoginViewController.swift
//  OldFriend
//
//  Created by 黄之信 on 17/3/20.
//  Copyright © 2017年 MichaelHuang. All rights reserved.
//

import UIKit
import TabPageViewController

class LoginViewController: UIViewController {
    @IBOutlet weak var OldFriendLogo: UIImageView!

    @IBAction func OldFriendAccountLoginButton(_ sender: UIButton) {
        let signUpButton = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(signUpButtonTapped))
        let tc = TabPageViewController.create()
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OldFriendAccountLoginTableViewController")
        
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MobileLoginViewController")
        tc.tabItems = [(vc1, "账号密码登录"), (vc2, "手机快捷登录")]
        var option = TabPageOption()
        option.tabWidth = view.frame.width / CGFloat(tc.tabItems.count)
        tc.option = option
        navigationController?.pushViewController(tc, animated: true)
        tc.navigationItem.rightBarButtonItem = signUpButton
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tc.title = "老友账号登录"

    }
    
    func signUpButtonTapped() {
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpTableViewController")
        navigationController?.pushViewController(vc1, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        OldFriendLogo.layer.cornerRadius = 30.0
        OldFriendLogo.clipsToBounds = true
    }
}

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
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBAction func HideTextFieldButton(_ sender: UIButton) {
        passWord.isSecureTextEntry = !passWord.isSecureTextEntry
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let result = oldFriendAccountLogin(phone: mobileTextField.text!, password: passwordTextField.text!)
        if ((result["ret"] as! Int) == 0) {
            self.performSegue(withIdentifier: "OldFriendAccountLoginSegue", sender: self)
        }
        else if ((result["error"] as! String) == "username or password is wrong") {
            let alertController = UIAlertController(title: "",
                                                    message: "账号或者密码错误", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "知道了", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func forgetPasswordButtonTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindPasswordPhoneNumberTableViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        let dict:NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [String : AnyObject]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        passWord.isSecureTextEntry = false
        self.tableView.isScrollEnabled = false
        let navigationHeight = topLayoutGuide.length
        tableView.contentInset.top = navigationHeight + TabPageOption().tabHeight
        // 这段代码相当于把表格移到合适位置
    }
}

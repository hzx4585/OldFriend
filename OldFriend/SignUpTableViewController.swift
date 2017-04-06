//
//  SignUpTableViewController.swift
//  OldFriend
//
//  Created by 黄之信 on 17/3/24.
//  Copyright © 2017年 MichaelHuang. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController {
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBAction func getVerificationCode(_ sender: UIButton) {
        if (check(phoneNumber: phoneNumberTextField.text!)) {
            var result = sendVerificationCode(phoneNumber: Int(phoneNumberTextField.text!)!)
            switch result {
            case 0:
                self.performSegue(withIdentifier: "getVerificaionCodeSegue", sender: self)
            default:
                print("something wrong")
            }
        }
        else {
            let alertController = UIAlertController(title: "",
                                                    message: "请输入正确的手机号", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "知道了", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getVerificaionCodeSegue" {
            let destinationController = segue.destination as! InputVerificationCodeTableViewController
            print("phoneNumber: " + phoneNumberTextField.text!)
            if let phoneNumber = phoneNumberTextField.text {
                destinationController.setValue(phoneNumber, forKey: "phoneNumber")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}

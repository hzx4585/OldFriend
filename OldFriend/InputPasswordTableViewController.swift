//
//  InputPasswordTableViewController.swift
//  
//
//  Created by 黄之信 on 17/3/30.
//
//

import UIKit

class InputPasswordTableViewController: UITableViewController {
    @IBOutlet weak var firstPasswordField: UITextField!
    @IBOutlet weak var secondPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isScrollEnabled = false
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        var result = true
        if (!checkTwoPasswordWhetherSame(firstPassword: firstPasswordField.text!, secondPassword: secondPasswordField.text!)) {
            result = false
            let alertController = UIAlertController(title: "",
                                                    message: "两次密码不相同", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "知道了", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if (result) {
            self.performSegue(withIdentifier: "registerFinalSegue", sender: self)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
